package com.kh.tt.message;

import java.util.concurrent.ConcurrentHashMap;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.web.socket.WebSocketSession;

public class ChatRoomManager {
    private static final ConcurrentHashMap<String, List<WebSocketSession>> roomMap = new ConcurrentHashMap<>();

    public static void addSession(String roomId, WebSocketSession session) {
        roomMap.computeIfAbsent(roomId, k -> new CopyOnWriteArrayList<>()).add(session);
    }

    public static void removeSession(String roomId, WebSocketSession session) {
        List<WebSocketSession> list = roomMap.get(roomId);
        if (list != null) list.remove(session);
    }

    public static List<WebSocketSession> getRoomSessions(String roomId) {
        return roomMap.getOrDefault(roomId, new CopyOnWriteArrayList<>());
    }
}
