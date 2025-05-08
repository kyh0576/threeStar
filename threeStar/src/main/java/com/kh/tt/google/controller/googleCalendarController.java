package com.kh.tt.google.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class googleCalendarController {
	   
   @RequestMapping("calendarDetail.do")
   public String Calendar() {
      return "calendar/googleCalendar";
   }
	
}
