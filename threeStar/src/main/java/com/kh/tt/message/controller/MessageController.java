package com.kh.tt.message.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;

import com.kh.tt.message.model.vo.Message;
import com.kh.tt.chat.model.service.ChattingRoomService;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.message.model.service.MessageService;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService messageService;


    // 메시지 메인 화면 이동
    @RequestMapping("/mainForm")
    public String showMessageMainForm(Model model) {
        model.addAttribute("page", "chat");
        return "message/messageMainForm"; // => /WEB-INF/views/message/messageMainForm.jsp
    }

    // 메시지 저장 요청 처리
    @PostMapping("/save")
    @ResponseBody
    public String saveMessage(@RequestBody Message message) {
        int result = messageService.saveMessage(message);
        return result > 0 ? "success" : "fail";
    }
    
    @RequestMapping("/messageForm")
    public String showMessageForm() {
        return "message/messageMainForm";  // => /WEB-INF/views/message/messageMainForm.jsp
    }
    
//==================이전에 한 메시지 화면에 띄우기================  
    @GetMapping(value = "/history", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<Message> getChatHistory(@RequestParam("roomId") int roomId) {
        return messageService.sendMessage(roomId);
    }
    
}
