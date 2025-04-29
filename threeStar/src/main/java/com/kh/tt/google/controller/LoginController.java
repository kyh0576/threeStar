package com.kh.tt.google.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.tt.google.model.service.GoogleLoginService;
import com.kh.tt.member.model.vo.Member;


@Controller
public class LoginController {
	
	@Autowired
	private GoogleLoginService gService;
	
	@RequestMapping("googleLogin.do")
	public String loginUrlGoogle(Member g, Model model) {
		int result = gService.SelectGoogleLogin(g);
		
		if(result > 0) {
			model.addAttribute("errorMsg", "실험중");
			return "redirect:/";
		}else {
			model.addAttribute("errorMsg", "실험중");
			return "redirect:/";
		}
		
	}
}
