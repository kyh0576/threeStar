package com.kh.tt.calendar.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.tt.calendar.model.service.CalendarServiceImpl;
import com.kh.tt.calendar.model.vo.Calendar;
import com.kh.tt.member.model.vo.Member;

@Controller
public class CalendarController {
	
	@Autowired
	private CalendarServiceImpl cService;
	
	@RequestMapping(value="calendar.do", method=RequestMethod.POST)
	public String InsertCalendar(Calendar c, HttpSession session, Model model) {

		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember != null) {
			c.setCalWriter(loginMember.getMemNo());
		}else {
			model.addAttribute("errorMsg", "로그인이 필요합니다.");
			return "redirect:/";
		}

		int result = cService.InsertCalendar(c);
		
		if(result > 0) {
			
			List<Calendar> calendarList = cService.SelectCalendar(c);
			model.addAttribute("calendarList", calendarList);
			return "calendar/calendarDetail";
		}else {
			model.addAttribute("errorMsg", "오류 발생! 다시 시도해 주세요.");
			return "calendar/calendarDetail";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value="/calendar/getEvents.do", produces = "application/json; charset=UTF-8")
	public List<Calendar> SelectCalendar(HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		
	    if (loginMember == null) {
	        return new ArrayList<>(); // 비로그인 상태면 빈 리스트 리턴
	    }
		
	    Calendar c = new Calendar();
	    c.setCalWriter(loginMember.getMemNo());

	    return cService.SelectCalendar(c);
		    
	}


	@RequestMapping(value="/calendar/update.do", method=RequestMethod.POST)
	public String updateCalendar(Calendar c, HttpSession session, Model model) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember != null) {
			c.setCalWriter(loginMember.getMemNo());
		}else {
			model.addAttribute("errorMsg", "로그인이 필요합니다.");
			return "redirect:/";
		}
		
		int result = cService.updateCalendar(c);
	    
		if(result > 0) {
			session.setAttribute("alertMsg", "수정이 완료됐습니다.");
			return "calendar/calendarDetail";
		}else {
			model.addAttribute("errorMsg", "수정에 실패했습니다.");
			return "calendar/calendarDetail";
		}
	}
	
	@RequestMapping(value="/calendar/delete.do", method=RequestMethod.POST)
	public String deleteCalendar(Calendar c, HttpSession session, Model model) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember != null) {
			c.setCalWriter(loginMember.getMemNo());
		}else {
			model.addAttribute("errorMsg", "로그인이 필요합니다.");
			return "redirect:/";
		}
		
		int result = cService.deleteCalendar(c);
	    
		if(result > 0) {
			session.setAttribute("alertMsg", "삭제 완료됐습니다.");
			return "calendar/calendarDetail";
		}else {
			model.addAttribute("errorMsg", "삭제 실패했습니다.");
			return "calendar/calendarDetail";
		}
	}


}
