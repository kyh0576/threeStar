package com.kh.tt.message.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.kh.tt.message.model.vo.Message;
import com.kh.tt.chat.model.service.ChattingRoomService;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.message.model.service.MessageService;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private ChattingRoomService chattingRoomService;

    // 메시지 메인 화면 이동
    @RequestMapping("/mainForm")
    public String showMessageMainForm(Model model) {
        model.addAttribute("page", "chat");
        return "message/messageMainForm";
    }

    // 메시지 저장 요청 처리
    @PostMapping("/save")
    @ResponseBody
    public String saveMessage(@RequestBody Message message) {
        System.out.println("🔔 DB 저장 요청 받은 메시지: " + message);
        int result = messageService.saveMessage(message);
        return result > 0 ? "success" : "fail";
    }

    @RequestMapping("/messageForm")
    public String showMessageForm() {
        return "message/messageMainForm";
    }

    // 이전 채팅 불러오기
    @GetMapping(value = "/history", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<Message> getChatHistory(@RequestParam("roomId") int roomId) {
        return messageService.sendMessage(roomId);
    }

    // 상대방 닉네임 가져오기
    @RequestMapping("/roomForm")
    public String showMainForm(@RequestParam("roomId") int roomId,
                               HttpSession session,
                               Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        int myMemNo = loginMember.getMemNo();

        Member targetMember = chattingRoomService.findTargetMember(roomId, myMemNo);

        model.addAttribute("targetNickname", targetMember.getMemName());
        model.addAttribute("roomId", roomId);

        return "message/mainMessageForm";
    }

    // [✅ 추가 가능성] -> 추후 서버에 파일 저장을 원하면 여기에 파일 업로드 메서드 추가 가능
    
    
    
//첨부파일 업로드
    @PostMapping("/upload")
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();

        try {
            ServletContext context = request.getSession().getServletContext();
            String savePath = context.getRealPath("/resources/uploadFiles/");

            File folder = new File(savePath);
            if (!folder.exists()) folder.mkdirs();

            String originName = file.getOriginalFilename();
            String saveName = System.currentTimeMillis() + "_" + originName;

            // 저장
            File targetFile = new File(savePath, saveName);
            file.transferTo(targetFile);
            
            System.out.println("💡 저장 경로: " + savePath);
            System.out.println("💡 파일명: " + saveName);

            // ✅ 응답에 반드시 imageUrl 포함!
            String contextPath = request.getContextPath();
            result.put("imageUrl", contextPath + "/resources/uploadFiles/" + saveName);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("imageUrl", null);  // ❌ 이게 프론트에서 에러 나는 이유!
        }

        return result;
    }



}


