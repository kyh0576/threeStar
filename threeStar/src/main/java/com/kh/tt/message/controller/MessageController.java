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
        // 파일이 포함된 메시지일 경우도 저장 (DB에는 originName, changeName만 저장 가능)
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
            // 📌 올바른 ServletContext 가져오기
            ServletContext context = request.getSession().getServletContext();
            String savePath = context.getRealPath("/resources/uploadFiles/");

            File folder = new File(savePath);
            if (!folder.exists()) folder.mkdirs();

            // 파일 이름 생성
            String originName = file.getOriginalFilename();
            String saveName = System.currentTimeMillis() + "_" + originName;
            
            System.out.println(originName);
            System.out.println(saveName);

            // 파일 저장
            File targetFile = new File(savePath, saveName);
            file.transferTo(targetFile);

            // 클라이언트가 접근 가능한 URL로 반환
            result.put("imageUrl", "/resources/uploadFiles/" + saveName);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("imageUrl", null);
        }

        return result;
    }

}


