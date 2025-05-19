package com.kh.tt.config;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JwtTokenTest {

    public static void main(String[] args) {
        
        String token = Jwts.builder()
                .setSubject("admina") // 유저 ID
                .claim("memNo", 1)    // 회원 번호 (로그인된 사용자 정보라고 가정)
                .claim("memName", "관리자") // 이름
                .signWith(SignatureAlgorithm.HS256, "secretKey")
                .compact();

        System.out.println("JWT 토큰 발급 → " + token);
        
    }
}
