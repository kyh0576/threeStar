package com.kh.tt.profile.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/verify-password")
public class Encoder {
	
	private final BCryptPasswordEncoder bcryptPasswordEncoder;
	
	// 생성자에서 BCryptPasswordEncoder 주입
    public Encoder(BCryptPasswordEncoder bcryptPasswordEncoder) {
        this.bcryptPasswordEncoder = bcryptPasswordEncoder;
    }

    @PostMapping
    public Map<String, Object> verifyPassword(@RequestBody Map<String, String> body) {
        String enteredPassword = body.get("password");

        // 저장된 비밀번호 (예시로 hard-coded 된 비밀번호 사용)
        String storedPasswordHash = "$2a$10$D/0LgKnwVfgP1.sjzGe6teygd/40XQpFgk6PZYJ2W0El5DQ8DQuYy"; // 예시 해시 값

        boolean isPasswordValid = bcryptPasswordEncoder.matches(enteredPassword, storedPasswordHash);

        Map<String, Object> response = new HashMap<>();
        response.put("success", isPasswordValid);

        return response;
    }

}
