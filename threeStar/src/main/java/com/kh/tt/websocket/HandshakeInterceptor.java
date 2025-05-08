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

            // 1. 세션 인증
            if (session != null) {
                Object loginMember = session.getAttribute("loginMember");
                if (loginMember != null) {
                    attributes.put("loginMember", loginMember);
                    System.out.println("[HandshakeInterceptor] 세션 인증 성공");
                    return super.beforeHandshake(request, response, wsHandler, attributes);
                }
            }

            // 2. JWT 인증
            String token = servletRequest.getServletRequest().getParameter("token");

            if (token != null && !token.isEmpty()) {
                try {
                    Claims claims = Jwts.parser()
                                        .setSigningKey("secretKey")
                                        .parseClaimsJws(token)
                                        .getBody();

                    String memId = claims.getSubject();
                    Object memNoObj = claims.get("memNo");
                    int memNo = 0;
                    if (memNoObj instanceof Integer) memNo = (Integer) memNoObj;
                    else if (memNoObj instanceof String) memNo = Integer.parseInt((String) memNoObj);
                    else if (memNoObj instanceof Double) memNo = ((Double) memNoObj).intValue();

                    String memName = (String) claims.get("memName");

                    Member tokenUser = new Member();
                    tokenUser.setMemId(memId);
                    tokenUser.setMemNo(memNo);
                    tokenUser.setMemName(memName);

                    attributes.put("loginMember", tokenUser);
                    System.out.println("[HandshakeInterceptor] JWT 인증 성공 → " + memId);
                    return super.beforeHandshake(request, response, wsHandler, attributes);

                } catch (Exception e) {
                    System.out.println("[HandshakeInterceptor] JWT 인증 실패");
                    return false;
                }
            }

            System.out.println("[HandshakeInterceptor] 인증 실패 → 연결 거부");
            return false;
        }

        return super.beforeHandshake(request, response, wsHandler, attributes);
    }
}
