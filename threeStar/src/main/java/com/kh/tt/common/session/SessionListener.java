package com.kh.tt.common.session;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        SessionCollector.addSession(se.getSession());
        System.out.println("✅ 세션 생성됨: " + se.getSession().getId());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        SessionCollector.removeSession(se.getSession());
        System.out.println("❌ 세션 종료됨: " + se.getSession().getId());
    }
}
