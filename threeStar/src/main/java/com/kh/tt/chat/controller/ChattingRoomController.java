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
import com.kh.tt.message.model.service.MessageService;

@Controller
@RequestMapping("/chattingRoom")
public class ChattingRoomController {
	
	@Autowired
    private ChattingRoomService chattingRoomService;
	
	@Autowired
	private MessageService messageService;
	
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
                // ✅ 메시지 삭제
                messageService.deleteMessagesByUserInRoom(existingRoomId, myMemNo);

                // ✅ 복구
                chattingRoomService.restoreChatRoom(existingRoomId, myMemNo);

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
    public List<Map<String, Object>> getMyChatRooms(HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginMember");
        if (loginUser == null) return Collections.emptyList();

        int myMemNo = loginUser.getMemNo();
        List<ChattingRoom> rooms = chattingRoomService.getChatRoomsByMemberId(loginUser.getMemId());

        return rooms.stream().map(room -> {
            Map<String, Object> map = new HashMap<>();
            map.put("chatId", room.getChatId());
            map.put("chatName", room.getChatName());
            map.put("lastMessage", room.getLastMessage());

            // ✅ 여기서 상대방 이름 가져오기
            List<Member> members = chattingRoomService.getChatRoomMembers(room.getChatId());
            String targetName = members.stream()
                .filter(m -> m.getMemNo() != myMemNo)
                .findFirst()
                .map(Member::getMemName)
                .orElse("이름없음");

            map.put("targetName", targetName);
            return map;
        }).collect(Collectors.toList());
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

        // 기본값이면 상대방 닉네임으로 변경
        if ("채팅방".equals(resultName)) {
            List<Member> targetMemberList = chattingRoomService.findTargetMember(roomId, myMemNo);
            if (targetMemberList != null && !targetMemberList.isEmpty()) {
                resultName = targetMemberList.get(0).getMemName();  // ✅ 첫 번째 상대 이름
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

  //=================================== 오른쪽 +add친구초대 ===================================

    @PostMapping("invite")
    @ResponseBody
    public String inviteFriend(@RequestBody Map<String, Object> body, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "fail";

        int chatId = Integer.parseInt(body.get("chatId").toString());
        List<Integer> membersToInvite = ((List<?>) body.get("members")).stream()
                .map(obj -> Integer.parseInt(obj.toString()))
                .collect(Collectors.toList());

        try {
            // ✅ 이미 참여 중인 멤버 필터링
            List<Integer> existingMembers = chattingRoomService.findExistingMembersInRoom(chatId, membersToInvite);

            for (int memNo : membersToInvite) {
                if (!existingMembers.contains(memNo)) {
                    chattingRoomService.insertRoomMember(chatId, memNo, "그룹 채팅");
                }
            }

            // ✅ 채팅방 이름을 현재 멤버 전체 이름 기준으로 업데이트
            List<String> allMemberNames = chattingRoomService.findMemberNamesInRoom(chatId);
            String updatedName = String.join(", ", allMemberNames);
            chattingRoomService.updateChatRoomName(chatId, updatedName);

            return "success";

        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    //=================================== 채팅방이름변경 ===================================
    @PostMapping("rename")
    @ResponseBody
    public String renameChatRoom(@RequestParam int roomId, @RequestParam String newName, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        int memNo = loginMember.getMemNo();

        try {
            int result = chattingRoomService.renameChatRoom(roomId, newName, memNo);
            return result > 0 ? "success" : "fail";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    
}