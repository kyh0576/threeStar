import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;

public class SessionCollector {

    private static final Map<String, HttpSession> sessions = new ConcurrentHashMap<>();

    public static void addSession(HttpSession session) {
        sessions.put(session.getId(), session);
    }

    public static void removeSession(HttpSession session) {
        sessions.remove(session.getId());
    }

    public static HttpSession getSessionById(String sessionId) {
        return sessions.get(sessionId);
    }
}
