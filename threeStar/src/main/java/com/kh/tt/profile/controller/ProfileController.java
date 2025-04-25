package com.kh.tt.profile.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.tt.profile.model.service.ProfileServiceImpl;
import com.kh.tt.profile.model.vo.Profile;

@Controller
public class ProfileController {
	
	@Autowired
	private ProfileServiceImpl pService;
	
    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
	
    @RequestMapping("profile.do")
//	public String selectProfile (@RequestParam(value="memNo") int memNo, Model model) {	
    public String selectProfile () {	
//    	int result = pService.selectProfile(memNo);
//		
//		System.out.println("controller : " + result);
//		
//		if(result > 0) {
			return "profile/profile";
//		}else {
//			model.addAttribute("errorMsg", "조회 실패");
//			return "common/mainPage";
//		}
	}
	
	@RequestMapping("detailProfile.do")
	public String selectProfileDetail() {
		return "profile/profileDetail";
	}
	
	@ResponseBody
	@RequestMapping("profileUpdate.do")
	public String profileUpdate(Profile p, HttpSession session, Model model) {
		
		String encPwd = bcryptPasswordEncoder.encode(p.getMemPwd());
		
		p.setMemPwd(encPwd); // 객체의 Pwd에 평문이 아닌 암호문으로 변경
		
		int result = pService.updateProfile(p);
		System.out.println("profile업뎃 : " + result);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "수정 성공");
			return "redirect:/";
		}else {
			model.addAttribute("errorMsg", "수정 실패");
			return "common/mainPage";
		}
		
	}
	
	

}
