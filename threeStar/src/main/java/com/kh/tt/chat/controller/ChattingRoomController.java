package com.kh.tt.chat.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.tt.chat.model.service.ChattingRoomService;
import com.kh.tt.chat.model.vo.ChattingRoom;
import com.kh.tt.member.model.vo.Member;

@Controller
@RequestMapping("/chattingRoom")
public class ChattingRoomController {
	
	@Autowired
    private ChattingRoomService chattingRoomService;
	
	 // ==================== 채팅관련 ====================

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
    
    // ==================== 채팅방 ====================
    
    @GetMapping("/rooms")
    @ResponseBody
    public List<ChattingRoom> getMyChatRooms(HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginMember");
        if (loginUser == null) return Collections.emptyList();  // 로그인 안 한 경우

        return chattingRoomService.getChatRoomsByMemberId(loginUser.getMemId());
    }
    
    
    // ==================== ====================  
    @GetMapping(value = "/roomName", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String getChatRoomName(@RequestParam("roomId") int roomId, HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        int myMemNo = loginMember.getMemNo();

        // 채팅방 정보 가져오기
        ChattingRoom room = chattingRoomService.selectChatRoomById(roomId);

        // 기본 이름 세팅
        String resultName = room != null ? room.getChatName() : "이름없음";

        // 만약 채팅방 이름이 "채팅방"이면 → 상대방 닉네임 가져와서 세팅
        if ("채팅방".equals(resultName)) {
            Member targetMember = chattingRoomService.findTargetMember(roomId, myMemNo);
            if (targetMember != null) {
                resultName = targetMember.getMemName();
            }
        }

        return resultName;
    }
    
    //==============오른쪽에 채팅방 맴버 뜨는거===============
    @GetMapping(value = "/members")
    @ResponseBody
    public List<Member> getChatRoomMembers(@RequestParam("roomId") int roomId) {
        return chattingRoomService.getChatRoomMembers(roomId);
    }
    
    // ====================채팅방 나가기====================  

    @PostMapping("/exit")
    @ResponseBody
    public String exitChatRoom(@RequestParam("chatId") int chatId,
                               @RequestParam("memNo") int memNo) {
        System.out.println("🔥 받은 chatId: " + chatId);
        System.out.println("🔥 받은 memNo: " + memNo);
        
        int result = chattingRoomService.exitChatRoom(chatId, memNo);
        return result > 0 ? "success" : "fail";
    }
    
    
    //=================================== 그룹채팅 ===================================

    @PostMapping("/startGroupChat")
    @ResponseBody
    public Map<String, Object> startGroupChat(@RequestBody Map<String, Object> body, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        int myMemNo = loginMember.getMemNo();

        List<Object> rawList = (List<Object>) body.get("members");
        List<Integer> members = rawList.stream()
            .map(obj -> Integer.parseInt(obj.toString()))
            .collect(Collectors.toList());

        if (!members.contains(myMemNo)) {
            members.add(myMemNo); // 본인도 포함
        }

        int roomId = chattingRoomService.createGroupChatRoom(members);

        return Map.of("success", true, "roomId", roomId);
    }


    
}