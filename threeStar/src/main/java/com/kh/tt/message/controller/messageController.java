package com.kh.tt.message.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class messageController {
	
	 @RequestMapping("/message/mainForm")
		public String showMessageMainForm(Model model) {
		 model.addAttribute("page", "chat");
		    return "message/messageMainForm";  // => /WEB-INF/views/message/messageMainForm.jsp
		}

}
