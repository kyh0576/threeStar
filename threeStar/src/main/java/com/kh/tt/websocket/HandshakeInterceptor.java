package com.kh.tt.websocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Component
public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor {

    @Override
    public boolean beforeHandshake(
            ServerHttpRequest request,
            ServerHttpResponse response,
            WebSocketHandler wsHandler,
            Map<String, Object> attributes) throws Exception {

        System.out.println("[HandshakeInterceptor] WebSocket 핸드셰이크 시작");

        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpSession session = servletRequest.getServletRequest().getSession(false);

            if (session != null) {
                Object loginMember = session.getAttribute("loginMember");
                if (loginMember != null) {
                    System.out.println("[HandshakeInterceptor] loginMember 복사 성공: " + loginMember);
                    attributes.put("loginMember", loginMember);
                } else {
                    System.out.println("[HandshakeInterceptor] loginMember 없음");
                }
            } else {
                System.out.println("[HandshakeInterceptor] HttpSession 없음");
            }
        }

        return super.beforeHandshake(request, response, wsHandler, attributes);
    }
}
