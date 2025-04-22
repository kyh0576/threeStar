package com.kh.tt.message;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class messageController {
	
	 @RequestMapping("/message/mainForm")
		public String showMessageMainForm() {
		    return "message/messageMainForm";  // => /WEB-INF/views/message/messageMainForm.jsp
		}

}
