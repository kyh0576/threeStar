package com.kh.tt.google.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.tt.member.model.service.MemberServiceImpl;
import com.kh.tt.member.model.vo.Classes;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.google.model.service.GoogleLoginServiceImpl;
import com.kh.tt.member.controller.MemberController;


@Controller
public class LoginController {
	
	@Autowired
	private GoogleLoginServiceImpl gService;
	
	@Autowired
	private MemberServiceImpl mService;
	
	@RequestMapping(value = "googleLogin.do", method = RequestMethod.POST)
	public ModelAndView loginGoogle(HttpServletRequest request, HttpSession session, ModelAndView mv) {

		String memName = request.getParameter("memName");
		String email = request.getParameter("email");
		String snsKey = request.getParameter("snsKey");
		
		Member g = new Member();
		g.setMemName(memName);
		g.setEmail(email);
		g.setSnsKey(snsKey);
		
		int result = gService.loginUrlGoogle(g);
		
		if(result > 0) {
	        mv.addObject("snsKey", snsKey);
	        mv.addObject("memName", memName);
	        mv.addObject("email", email);
	        
	        Member loginMember = gService.loginGoogleMember(g);
			ArrayList<Classes> cList = mService.selectClass();
			
			if(loginMember != null) {
				mService.online(loginMember);
				session.setAttribute("loginMember", loginMember);
				session.setAttribute("cList", cList);
				
				session.setAttribute("alertMsg", "성공적으로 로그인 되었습니다.");
				mv.setViewName("common/mainPage");

			}else {
				mv.addObject("alertMsg", "로그인 실패! 일반 회원가입을 진행합니다.");
				mv.setViewName("member/signinForm");
			}
		}else {
			mv.addObject("alertMsg", "일반 회원가입을 진행합니다.");
			
	        mv.addObject("snsKey", snsKey);
	        mv.addObject("memName", memName);
	        mv.addObject("email", email);

			mv.setViewName("member/signinForm");
		}
		
		return mv;

	}       

		/*
		if(result > 0) {
			Member loginMember = gService.loginGoogleMember(g);
			System.out.println("구글 로긴멤버 : " + loginMember);
			ArrayList<Classes> cList = mService.selectClass();
			System.out.println("구글 로긴cList : " + cList);
			
			if(loginMember != null && loginMember.getSnsKey() != null) {
				mService.online(g);
				session.setAttribute("loginMember", loginMember);
				session.setAttribute("cList", cList);
				
				session.setAttribute("alertMsg", "성공적으로 로그인 되었습니다.");
				mv.setViewName("redirect:/main.me");
			}else {
				mv.addObject("alertMsg", "로그인 실패!");
				mv.setViewName("member/loginForm");
			}
		}else {
			// snsKey가 없으면 회원가입 폼으로 이동
	        mv.addObject("snsKey", snsKey);
	        mv.addObject("memName", memName);
	        mv.addObject("email", email);
	        mv.setViewName("member/signinForm");
		}
		*/
		
		
	/*
	@RequestMapping(value = "googleAutoLogin.do")
	public String loginAuto(Member g, HttpServletRequest request, Model model) {
		
		
		
		
			if(g.getMemId() != null) {
				return "redirect:loginGoogle.do";
			}else {
				return "member/signinForm";
			}
		}else {
			return "common/mainPage";
		}

	}
	
    @RequestMapping("loginGoogle.do")
    public ModelAndView loginMember(Member g, HttpSession session, ModelAndView mv) {
      
      Member loginMember = mService.loginMember(g);
      
      if(loginMember.getSnsKey() != null) {
          // 로그인 성공
          mService.online(g);
          session.setAttribute("loginMember", loginMember);
          
          session.setAttribute("alertMsg", "성공적으로 로그인 되었습니다.");
          mv.setViewName("redirect:/main.me");
       }else {
          // 로그인 실패
          mv.addObject("alertMsg", "로그인 실패!");
          mv.setViewName("member/loginForm");
       }
       
       System.out.println("로그인 맴버 : " + loginMember);
       return mv;
      
      // ArrayList<Classes> cList = mService.selectClass();
       * 
      if(loginMember != null && BCryptPasswordEncoder.matches(m.getMemPwd(), loginMember.getMemPwd())) {
         // 로그인 성공
         mService.online(m);
         session.setAttribute("loginMember", loginMember);
         session.setAttribute("cList", cList);
         
         session.setAttribute("alertMsg", "성공적으로 로그인 되었습니다.");
         mv.setViewName("redirect:/main.me");
      }else {
         // 로그인 실패
         mv.addObject("alertMsg", "로그인 실패!");
         mv.setViewName("member/loginForm");
      }
      
      System.out.println("로그인 맴버 : " + loginMember);
      return mv;
      */
   
	
}
