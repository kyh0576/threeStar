package com.kh.tt.google.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kh.tt.google.model.service.GoogleLoginServiceImpl;
import com.kh.tt.member.model.service.MemberServiceImpl;
import com.kh.tt.member.model.vo.Classes;
import com.kh.tt.member.model.vo.Member;

@Controller
public class googleCalendarController {
	
	@Autowired
	private GoogleLoginServiceImpl gService;
	
	@Autowired
	private MemberServiceImpl mService;
	   
	@RequestMapping(value = "calendarDetail.do")
	public ModelAndView Calendar(Member g, HttpServletRequest request, HttpSession session, ModelAndView mv) {
		
	    System.out.println("snsKey: " + g.getSnsKey());
	    System.out.println("email: " + g.getEmail());
		
        Member loginMember = gService.loginGoogleMember(g);

			if(loginMember.getSnsKey() != null) {
				session.setAttribute("loginMember", loginMember);
				mv.setViewName("calendar/googleCalendar");

			}else {
				mv.setViewName("calendar/calendarDetail");
				
			}

		return mv;

	}
	
}
