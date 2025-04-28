package com.kh.tt.chat.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.tt.chat.model.service.ChattingRoomService;
import com.kh.tt.member.model.vo.Member;

@Controller
@RequestMapping("/chattingRoom")
public class ChattingRoomController {
	
	@Autowired
    private ChattingRoomService chattingRoomService;
	
	 // ==================== [ 👇 여기 추가 👇 ] ====================

    @PostMapping("/startChat")
    @ResponseBody
    public Map<String, Object> startChat(@RequestBody Map<String, Object> requestBody, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            Member loginMember = (Member) session.getAttribute("loginMember");
            if (loginMember == null) {
                response.put("success", false);
                response.put("message", "로그인 정보 없음");
                return response;
            }

            int myMemNo = loginMember.getMemNo();
            int targetMemNo = Integer.parseInt(requestBody.get("targetUserId").toString());

            Integer existingRoomId = chattingRoomService.findChatRoom(myMemNo, targetMemNo);

            int roomId;
            if (existingRoomId != null) {
                roomId = existingRoomId;
            } else {
                roomId = chattingRoomService.createChatRoom(myMemNo, targetMemNo);
            }

            response.put("success", true);
            response.put("roomId", roomId);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
        }

        return response;
    }

}
