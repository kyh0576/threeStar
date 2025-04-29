package com.kh.tt.websocket;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.web.socket.WebSocketSession;

public class ChatRoomManager {

    // 각 채팅방(roomId)에 연결된 세션들을 저장하는 Map
    private static final Map<String, Set<WebSocketSession>> roomSessionMap = new HashMap<>();

    // 세션 추가
    public static synchronized void addSession(String roomId, WebSocketSession session) {
        roomSessionMap
            .computeIfAbsent(roomId, k -> Collections.synchronizedSet(new HashSet<>()))
            .add(session);
        System.out.println("✅ 채팅방 " + roomId + "에 세션 추가됨. 현재 인원: " + roomSessionMap.get(roomId).size());
    }

    // 세션 제거
    public static synchronized void removeSession(String roomId, WebSocketSession session) {
        Set<WebSocketSession> sessions = roomSessionMap.get(roomId);
        if (sessions != null) {
            sessions.remove(session);
            System.out.println("❌ 채팅방 " + roomId + "에서 세션 제거됨. 남은 인원: " + sessions.size());

            if (sessions.isEmpty()) {
                roomSessionMap.remove(roomId);
                System.out.println("⚠️ 채팅방 " + roomId + " 세션이 모두 종료되어 삭제됨");
            }
        }
    }

    // 세션 가져오기 (전체 전송용)
    public static Set<WebSocketSession> getRoomSessions(String roomId) {
        return roomSessionMap.getOrDefault(roomId, Collections.emptySet());
    }
}
