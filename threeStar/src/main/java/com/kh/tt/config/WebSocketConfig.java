package com.kh.tt.config;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.tt.websocket.ChatWebSocketHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    private ChatWebSocketHandler chatWebSocketHandler;  // ✅ 주입만 받자

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(chatWebSocketHandler, "/chat/{roomId}")  // ✅ new 없이 주입된 걸 사용
                .setAllowedOrigins("*")
                .addInterceptors(new HttpSessionHandshakeInterceptor() {
                    @Override
                    public void afterHandshake(org.springframework.http.server.ServerHttpRequest request,
                                               org.springframework.http.server.ServerHttpResponse response,
                                               org.springframework.web.socket.WebSocketHandler wsHandler,
                                               Exception ex) {
                        if (request instanceof org.springframework.http.server.ServletServerHttpRequest) {
                            HttpSession httpSession = ((org.springframework.http.server.ServletServerHttpRequest) request)
                                    .getServletRequest().getSession(false);

                            if (httpSession != null) {
                                System.out.println("✅ HTTP 세션 존재, 로그인 정보 복사 가능");
                            } else {
                                System.out.println("⚠️ HTTP 세션이 null입니다.");
                            }
                        }
                        super.afterHandshake(request, response, wsHandler, ex);
                    }
                });
    }
}
