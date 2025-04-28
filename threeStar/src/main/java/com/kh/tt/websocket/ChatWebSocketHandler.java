package com.kh.tt.websocket;

import java.util.List;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.tt.message.controller.ChatRoomManager;

public class ChatWebSocketHandler extends TextWebSocketHandler {

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String uri = session.getUri().toString(); // ws://localhost:8333/tt/chat/roomId
        String roomId = uri.substring(uri.lastIndexOf("/") + 1); // roomId 추출

        ChatRoomManager.addSession(roomId, session); // ✅ 세션 등록 필수

        System.out.println("[🔌 연결됨] roomId: " + roomId + ", sessionId: " + session.getId());
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String uri = session.getUri().toString();
        String roomId = uri.substring(uri.lastIndexOf("/") + 1);

        List<WebSocketSession> sessions = ChatRoomManager.getRoomSessions(roomId);

        for (WebSocketSession s : sessions) {
            if (s.isOpen()) {
                s.sendMessage(message);
            }
        }

        System.out.println("[💬 메시지] roomId: " + roomId + ", 내용: " + message.getPayload());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, org.springframework.web.socket.CloseStatus status) throws Exception {
        String uri = session.getUri().toString();
        String roomId = uri.substring(uri.lastIndexOf("/") + 1);

        ChatRoomManager.removeSession(roomId, session);

        System.out.println("[❌ 연결 종료] roomId: " + roomId + ", sessionId: " + session.getId());
    }
}
