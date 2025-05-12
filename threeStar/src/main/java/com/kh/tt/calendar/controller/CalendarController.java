package com.kh.tt.calendar.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.tt.calendar.model.service.CalendarServiceImpl;
import com.kh.tt.member.model.vo.Member;

@Controller
public class CalendarController {
	
	@Autowired
	private CalendarServiceImpl cService;
	
	@RequestMapping(value="calendar.do")
	public String InsertCalendar(Member c, HttpSession session, Model model) {
		int result = cService.InsertCalendar(c);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "일정이 성공적으로 추가되었습니다.");
			return "redirect:/";
		}else {
			model.addAttribute("errorMsg", "오류 발생! 다시 시도해 주세요.");
			return "redirect:/";
		}
		
	}
}
