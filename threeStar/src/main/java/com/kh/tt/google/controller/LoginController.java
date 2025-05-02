package com.kh.tt.google.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.tt.member.model.vo.Member;


@Controller
public class LoginController {
	
	@RequestMapping(value = "googleLogin.do", method = RequestMethod.POST)
	public String loginUrlGoogle(HttpServletRequest request, Model model) {

		String snsKey = request.getParameter("snsKey");
		String name = request.getParameter("memName");
		String email = request.getParameter("email");
		
		model.addAttribute("snsKey", snsKey);
		model.addAttribute("memName", name);
		model.addAttribute("email", email);
		
		return "member/signinForm";
		
	}
}
