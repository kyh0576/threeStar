package com.kh.tt.google.controller;

import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.tt.member.model.service.MemberServiceImpl;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.google.model.service.GoogleLoginServiceImpl;
import com.kh.tt.member.controller.MemberController;


@Controller
public class LoginController {
	
	@Autowired
	private GoogleLoginServiceImpl gService;
	
	@RequestMapping(value = "googleLogin.do", method = RequestMethod.POST)
	public String loginGoogle(HttpServletRequest request, Model model) {

		String snsKey = request.getParameter("snsKey");
		String name = request.getParameter("memName");
		String email = request.getParameter("email");
		
		model.addAttribute("snsKey", snsKey);
		model.addAttribute("memName", name);
		model.addAttribute("email", email);
		
		return "member/signinForm";

	}
	
	@RequestMapping(value = "googleAutoLogin.do")
	public String loginAuto(Member g, HttpServletRequest request, Model model) {
		
		int result = gService.loginUrlGoogle(g);
		
		if(result > 0) {
			if(g.getMemId() != null) {
				return "member/loginForm";
			}else {
				model.addAttribute("snsKey", g.getSnsKey());
				model.addAttribute("memName", g.getMemName());
				model.addAttribute("email", g.getEmail());
				return "member/signinForm";
			}
		}else {
			return "common/mainPage";
		}

	}
	
}
