package com.kh.tt.websocket;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

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
    private MessageService messageService; // ✅ 서비스 주입
    

    private ObjectMapper objectMapper = new ObjectMapper(); // 직접 생성
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        Member loginMember = (Member) session.getAttributes().get("loginMember");

        if (loginMember != null) {
            System.out.println("✅ WebSocket 세션에서 loginMember 가져오기 성공: " + loginMember.getMemId());
        } else {
            System.out.println("⚠️ WebSocket 세션에 loginMember 없음 (아직 복사 안 됨)"); 
        }

        String uri = session.getUri().toString();
        String roomId = uri.substring(uri.lastIndexOf("/") + 1);

        ChatRoomManager.addSession(roomId, session);
    }
    
    
//===========================================================================
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();  // 메시지 내용
        Map<String, Object> messageMap = objectMapper.readValue(payload, Map.class);  // JSON 파싱
        
        Message msg = new Message();
        msg.setMessageContent((String) messageMap.get("text"));  // 메시지 내용 설정

        Member loginMember = (Member) session.getAttributes().get("loginMember");
        if (loginMember != null) {
            msg.setMsMemNo(loginMember.getMemNo());  // 로그인된 회원 번호 설정
            System.out.println("✅ handleTextMessage - loginMember 있음: " + loginMember.getMemId());
        } else {
            System.out.println("⚠️ handleTextMessage - loginMember 없음");
        }

        // 방 번호 설정 (방 ID를 URL에서 추출)
        String roomIdStr = getRoomId(session);
        try {
            int roomId = Integer.parseInt(roomIdStr);  // 방 ID가 유효한 숫자인지 확인
            msg.setMsChatId(roomId);  // 메시지에 방 ID 설정
        } catch (NumberFormatException e) {
            System.out.println("🚫 roomId가 숫자가 아닙니다: " + roomIdStr);
            return;  // 방 번호가 유효하지 않으면 메시지 저장하지 않음
        }

        // DB에 메시지 저장
        messageService.saveMessage(msg);

        // 같은 방에 있는 다른 사람들에게 메시지 전달
        for (WebSocketSession sess : ChatRoomManager.getRoomSessions(roomIdStr)) {
            if (sess.isOpen()) {  // 연결이 열린 세션에만 메시지 전송
                sess.sendMessage(new TextMessage(payload));  // 다른 클라이언트로 메시지 전송
            }
        }
    }



//=============================================================================
    @Override
    public void afterConnectionClosed(WebSocketSession session, org.springframework.web.socket.CloseStatus status) throws Exception {
        String roomId = getRoomId(session);
        ChatRoomManager.removeSession(roomId, session);
    }

    // 방 ID를 얻는 메소드
    private String getRoomId(WebSocketSession session) {
        String uri = session.getUri().toString();
        return uri.substring(uri.lastIndexOf("/") + 1);
    }

    // 사용자 ID 얻는 메소드
    private int getUserId(WebSocketSession session) {
        // WebSocket 핸드쉐이크 때 세션에 로그인한 사용자 정보 넣어둔 경우 꺼내기
        Object userNo = session.getAttributes().get("loginMemberNo");
        return userNo != null ? (Integer) userNo : 0;
    }
}
