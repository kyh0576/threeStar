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
            System.out.println("✅ WebSocket 세션에서 loginMember 가져오기 성공: " + loginMember.getMemId());
        } else {
            System.out.println("⚠️ WebSocket 세션에 loginMember 없음");
        }

        String uri = session.getUri().toString();
        String roomId = uri.substring(uri.lastIndexOf("/") + 1);

        ChatRoomManager.addSession(roomId, session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        Map<String, Object> messageMap = objectMapper.readValue(payload, Map.class);

        // DB 저장용 객체 생성
        Message msg = new Message();

        // 로그인 사용자
        Member loginMember = (Member) session.getAttributes().get("loginMember");
        
        System.out.println("📌 [채팅방 목록] loginMember: " + loginMember);

        if (loginMember != null) {
            msg.setMsMemNo(loginMember.getMemNo());  
            msg.setSender(loginMember.getMemName());
            System.out.println("✅ handleTextMessage - loginMember 있음: " + loginMember.getMemId());
        } else {
            System.out.println("⚠️ handleTextMessage - loginMember 없음");
        }

        // 메세지 내용
        msg.setMessageContent((String) messageMap.get("text"));

        // 메시지 타입 (chat or file)
        msg.setType((String) messageMap.get("type"));

        // 파일이 있으면 originName, fileType 저장
        Map<String, Object> fileMap = (Map<String, Object>) messageMap.get("file");

        if ("file".equals(msg.getType()) && fileMap != null) {   
            msg.setOriginName((String) fileMap.get("name"));  
            msg.setFileType((String) fileMap.get("type"));    
            msg.setChangeName((String) fileMap.get("name"));  

            // 추가
            msg.setFileUrl((String) fileMap.get("fileUrl"));

            // 추가 → 브로드캐스트용 messageMap 에도 넣어야함 (이게 없으면 JS 에서 fileUrl 없음 오류)
            ((Map<String, Object>)messageMap.get("file")).put("fileUrl", fileMap.get("fileUrl"));
        }



        System.out.println("fileMap 데이터 : " + fileMap);

        // 방 번호
        String roomIdStr = getRoomId(session);
        try {
            int roomId = Integer.parseInt(roomIdStr);
            msg.setMsChatId(roomId);
        } catch (NumberFormatException e) {
            System.out.println("🚫 roomId가 숫자가 아닙니다: " + roomIdStr);
            return;
        }

        // DB 저장
        messageService.saveMessage(msg);

        // 브로드캐스트 → sender 포함해서 다시 payload 생성
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

    private int getUserId(WebSocketSession session) {
        Object userNo = session.getAttributes().get("loginMemberNo");
        return userNo != null ? (Integer) userNo : 0;
    }
}