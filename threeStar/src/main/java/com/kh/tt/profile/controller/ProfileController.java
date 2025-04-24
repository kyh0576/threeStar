package com.kh.tt.profile.controller;

import org.springframework.beans.factory.annotation.Autowired;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.tt.profile.model.service.ProfileServiceImpl;

@Controller
public class ProfileController {
	
	@Autowired
	private ProfileServiceImpl pService;
	
	@RequestMapping("profile.do") // 영훈 씨 모달용
//	public String selectProfile() {
//	public String selectProfile (@RequestParam(value="memNo", required=true) int memNo, Model model) {
//		if(memNo <= 0) {
//			model.addAttribute("errorMsg", "멤버가 아닙니다");
//			return "common/mainPage";
//		}
	public String selectProfile (@RequestParam(value="memNo") int memNo, Model model) {	
		int result = pService.selectProfile(memNo);
		
		System.out.println("controller : " + result);
		
		if(result > 0) {
			return "profile/profile";
		}else {
			model.addAttribute("errorMsg", "조회 실패");
			return "common/mainPage";
		}
	}
	
	@RequestMapping("detailProfile.do")
	public String selectProfileDetail() {
//	public String selectProfileDetail(int memNo, HttpSession session, Model model) {
//
//		int result = pService.selectProfileDetail(memNo);
//			System.out.println(result);
//		
//		if(result > 0) {
			return "profile/profileDetail";
//		}else {
//			model.addAttribute("errorMsg", "조회 실패");
//			return "common/mainPage";
//		}
		
	}

}
