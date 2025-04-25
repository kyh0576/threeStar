package com.kh.tt.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController  {
@RequestMapping("/common/mainMenu")
	public String showMainMenu(Model model) {
	    return "common/mainMenu"; // 실제 경로: /WEB-INF/views/common/mainMenu.jsp
}	

 @RequestMapping("/common/mainPage")
	public String mainPage(Model model) {
	 model.addAttribute("page", "home");
	    return "common/mainPage";  // => /WEB-INF/views/message/messageMainForm.jsp
	}
 
 @RequestMapping("/drawerAll/main")
 public String tdrawerPage(Model model) {
     model.addAttribute("page", "tdrawer");
     return "drawer/drawerAll"; // 실제 JSP 경로에 맞게 수정
 }

 @RequestMapping("/calendarDetail/main")
 public String calendarPage(Model model) {
     model.addAttribute("page", "calendar");
     return "calendar/calendarDetail"; // 실제 JSP 경로에 맞게 수정
 }
}
