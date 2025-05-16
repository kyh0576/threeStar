package com.kh.tt.config;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.tt.websocket.ChatWebSocketHandler;
import com.kh.tt.websocket.HandshakeInterceptor;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    private ChatWebSocketHandler chatWebSocketHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
<<<<<<< HEAD
        registry.addHandler(chatWebSocketHandler, "/chat/{roomId}")
                .setAllowedOrigins("*")
                .addInterceptors(handshakeInterceptor); // ✅ 주입한 걸 넣어야 한다!
=======
       registry.addHandler(chatWebSocketHandler, "/chat/{roomId}")
        .setAllowedOrigins("*")
        .addInterceptors(new HttpSessionHandshakeInterceptor());
>>>>>>> f7d1fbb2390108a62d6b6c8152e44cdb3b25521b
    }
}


