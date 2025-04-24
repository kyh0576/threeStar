package com.kh.tt.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController  {
@RequestMapping("/common/mainMenu")
	public String showMainMenu() {
	    return "common/mainMenu"; // 실제 경로: /WEB-INF/views/common/mainMenu.jsp
}	

 @RequestMapping("/common/mainPage")
	public String mainPage() {
	    return "common/mainPage";  // => /WEB-INF/views/message/messageMainForm.jsp
	}
 
 	@RequestMapping("/drawer/drawerAll")
 	public String drawerAll() {
 		return "drawer/drawerAll";
 	}
 	
 	@RequestMapping("/calendar/calendarDetail")
 	public String calendarDetail() {
 		return "calendar/calendarDetail";
 	}
 	
}
