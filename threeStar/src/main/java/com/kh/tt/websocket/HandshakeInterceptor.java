package com.kh.tt.websocket;

import java.util.Map;
import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.tt.member.model.vo.Member;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;

@Component
public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {

        System.out.println("[HandshakeInterceptor] WebSocket 핸드셰이크 시작");

        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpSession session = servletRequest.getServletRequest().getSession(false);

            // 1. 세션 인증 우선
            if (session != null) {
                Object loginMember = session.getAttribute("loginMember");
                if (loginMember != null) {
                    attributes.put("loginMember", loginMember);
                    return super.beforeHandshake(request, response, wsHandler, attributes);
                }
            }

            // 2. 토큰 기반 인증
            String token = servletRequest.getServletRequest().getParameter("token");

            if (token != null && !token.isEmpty()) {
                try {
                    Claims claims = Jwts.parser()
                                        .setSigningKey("secretKey")
                                        .parseClaimsJws(token)
                                        .getBody();

                    String memId = claims.getSubject();
                    int memNo = claims.get("memNo", Integer.class);
                    String memName = claims.get("memName", String.class);

                    Member member = new Member();
                    member.setMemId(memId);
                    member.setMemNo(memNo);
                    member.setMemName(memName);

                    attributes.put("loginMember", member);

                    return super.beforeHandshake(request, response, wsHandler, attributes);
                } catch (Exception e) {
                    System.out.println("[HandshakeInterceptor] JWT 인증 실패");
                    return false;
                }
            }
        }

        System.out.println("인증 실패 → 연결 거부");
        return false;
    }
}
