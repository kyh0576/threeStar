package com.kh.tt.websocket;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.tt.message.model.service.MessageService;
import com.kh.tt.message.model.vo.Message;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.message.controller.ChatRoomManager;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    @Autowired
    private MessageService messageService;

    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        Member loginMember = (Member) session.getAttributes().get("loginMember");
        String roomId = getRoomId(session);

        System.out.println("✅ 연결됨 - RoomId: " + roomId + ", 유저: " + loginMember);

        ChatRoomManager.addSession(roomId, session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        Map<String, Object> messageMap = objectMapper.readValue(payload, Map.class);

        Member loginMember = (Member) session.getAttributes().get("loginMember");
        String roomId = getRoomId(session);

        Message msg = new Message();
        msg.setMsMemNo(loginMember.getMemNo());
        msg.setSender(loginMember.getMemName());
        msg.setMsChatId(Integer.parseInt(roomId));
        msg.setType((String) messageMap.get("type"));

        // ✅ 공통 텍스트 메시지 처리
        msg.setMessageContent((String) messageMap.get("text"));

        // ✅ 파일 메시지일 경우, originName / changeName / fileType 설정
        if ("file".equals(msg.getType()) && messageMap.get("file") instanceof Map) {
            Map<String, Object> fileMap = (Map<String, Object>) messageMap.get("file");

            msg.setOriginName(msg.getMessageContent());  // 원래 파일명은 text에 저장됨
            msg.setChangeName((String) fileMap.get("name"));
            msg.setFileType((String) fileMap.get("type"));
        }
        // ✅ DB 저장
        messageService.saveMessage(msg);

        // ✅ 다시 클라이언트에게 전송
        messageMap.put("sender", loginMember.getMemName());
        String sendPayload = objectMapper.writeValueAsString(messageMap);

        for (WebSocketSession sess : ChatRoomManager.getRoomSessions(roomId)) {
            if (sess.isOpen()) {
                sess.sendMessage(new TextMessage(sendPayload));
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String roomId = getRoomId(session);
        ChatRoomManager.removeSession(roomId, session);
    }

    private String getRoomId(WebSocketSession session) {
        String uri = session.getUri().toString();
        String path = uri.split("\\?")[0];
        return path.substring(path.lastIndexOf("/") + 1);
    }
}
