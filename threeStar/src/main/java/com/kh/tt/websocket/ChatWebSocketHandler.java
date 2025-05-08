package com.kh.tt.websocket;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
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

        if (loginMember != null) {
            System.out.println("✅ WebSocket 세션에 로그인 성공: " + loginMember.getMemId());
        } else {
            System.out.println("⚠️ WebSocket 세션에 loginMember 없음");
        }

        String roomId = getRoomId(session);
        ChatRoomManager.addSession(roomId, session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        Map<String, Object> messageMap = objectMapper.readValue(payload, Map.class);

        Member loginMember = (Member) session.getAttributes().get("loginMember");

        if (loginMember == null) {
            System.out.println("🚫 로그인 정보가 없어 메시지 처리 불가 (WebSocket 인증 문제)");
            return;  // 여기서 return 안하면 null로 DB insert 하면서 오류 발생함
        }

        String roomIdStr = getRoomId(session);

        // 메세지 객체 준비
        Message msg = new Message();
        msg.setMsMemNo(loginMember.getMemNo());
        msg.setSender(loginMember.getMemName());
        msg.setMessageContent((String) messageMap.get("text"));
        msg.setType((String) messageMap.get("type"));

        // 파일 정보 처리
        Map<String, Object> fileMap = (Map<String, Object>) messageMap.get("file");
        if ("file".equals(msg.getType()) && fileMap != null) {
            msg.setOriginName((String) fileMap.get("name"));
            msg.setFileType((String) fileMap.get("type"));
            msg.setChangeName((String) fileMap.get("name"));
            msg.setFileUrl((String) fileMap.get("fileUrl"));

            // 브로드캐스트용 fileMap에도 fileUrl 삽입 (JS에서 필요함)
            fileMap.put("fileUrl", fileMap.get("fileUrl"));
        }

        System.out.println("📁 fileMap 데이터 : " + fileMap);

        try {
            int roomId = Integer.parseInt(roomIdStr);
            msg.setMsChatId(roomId);
        } catch (NumberFormatException e) {
            System.out.println("🚫 방 ID가 잘못됨: " + roomIdStr);
            return;
        }

        // DB 저장
        messageService.saveMessage(msg);

        // 브로드캐스트용 payload 재생성
        messageMap.put("sender", loginMember.getMemName());
        String sendPayload = objectMapper.writeValueAsString(messageMap);

        for (WebSocketSession sess : ChatRoomManager.getRoomSessions(roomIdStr)) {
            if (sess.isOpen()) {
                sess.sendMessage(new TextMessage(sendPayload));
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, org.springframework.web.socket.CloseStatus status) throws Exception {
        String roomId = getRoomId(session);
        ChatRoomManager.removeSession(roomId, session);
    }

    private String getRoomId(WebSocketSession session) {
        String uri = session.getUri().toString();
        return uri.substring(uri.lastIndexOf("/") + 1);
    }
}
