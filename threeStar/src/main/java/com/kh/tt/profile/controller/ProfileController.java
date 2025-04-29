package com.kh.tt.profile.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.tt.member.model.dao.MemberDao;
import com.kh.tt.member.model.service.MemberService;
import com.kh.tt.member.model.service.MemberServiceImpl;
import com.kh.tt.member.controller.MemberController;
import com.kh.tt.member.model.vo.Classes;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.service.ProfileServiceImpl;

@Controller
public class ProfileController {
	
   @Autowired
    private MemberServiceImpl mService;


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
	public String selectProfileDetail(Member p, Model model, HttpSession session, HttpServletResponse response) throws IOException {
		
		Member loginMember = mService.loginMember(p);
		
		Member profile = pService.detailProfile(p);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(loginMember != null && bcryptPasswordEncoder.matches(p.getMemPwd(), loginMember.getMemPwd())) {
			session.setAttribute("loginMember", loginMember);
			session.setAttribute("profile", profile);
			out.println("<script>");
			out.println("alert('수정 성공');");
			out.println("parent.location.reload();");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('비밀번호가 틀렸습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		out.flush();
		return null;
	}
	
	
   @RequestMapping("login.do")
   public ModelAndView loginMember(Member p, HttpSession session, ModelAndView mv) {
      
      Member loginMember = mService.loginMember(p);
      
      ArrayList<Classes> cList = mService.selectClass();
      
      if(loginMember != null && bcryptPasswordEncoder.matches(p.getMemPwd(), loginMember.getMemPwd())) {
         // 로그인 성공
         mService.online(p);
         session.setAttribute("loginMember", loginMember);
         session.setAttribute("cList", cList);
         
         session.setAttribute("alertMsg", "성공적으로 로그인 되었습니다.");
         mv.setViewName("redirect:/tt/main.me");
      }else {
         // 로그인 실패
         mv.addObject("alertMsg", "로그인 실패!");
         mv.setViewName("member/loginForm");
      }
      return mv;
   }

	
	@RequestMapping("profileUpdate.do")
	public String profileUpdate(Member p, HttpSession session, Model model, HttpServletResponse response) throws IOException  {
		
		String encPwd = bcryptPasswordEncoder.encode(p.getMemPwd());
		
		p.setMemPwd(encPwd); // 객체의 Pwd에 평문이 아닌 암호문으로 변경
		
		int result = pService.updateProfile(p);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			session.setAttribute("loginMember", mService.loginMember(p));
			out.println("<script>");
			// out.println("alert('수정 성공');");
			// out.println("parent.location.reload();");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('수정 실패');");
			out.println("history.back();");
			out.println("</script>");
		}
		out.flush();
		return "member/myPageCheck";
	}
	
	@RequestMapping("profileCheck.do")
	public String profileCheck() {
		return "member/myPage";
	}
	

}
