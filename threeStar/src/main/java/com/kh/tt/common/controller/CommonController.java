package com.kh.tt.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController  {
@RequestMapping("/common/mainMenu")
	public String showMainMenu() {
	    return "common/mainMenu"; // 실제 경로: /WEB-INF/views/common/mainMenu.jsp
}
	
 @RequestMapping("/message/mainForm")
	public String showMessageMainForm() {
	    return "message/messageMainForm";  // => /WEB-INF/views/message/messageMainForm.jsp
	}
 

 @RequestMapping("/member/chat")
	public String chatForm() {
	    return "member/chat";  // => /WEB-INF/views/message/messageMainForm.jsp
	}
}
