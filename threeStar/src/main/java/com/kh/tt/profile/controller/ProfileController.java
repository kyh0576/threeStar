package com.kh.tt.profile.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.tt.member.model.dao.MemberDao;
import com.kh.tt.member.model.service.MemberService;
import com.kh.tt.member.model.service.MemberServiceImpl;
import com.kh.tt.chat.model.service.ChattingRoomService;
import com.kh.tt.member.controller.MemberController;
import com.kh.tt.member.model.vo.Classes;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.service.ProfileServiceImpl;
import com.kh.tt.profile.model.vo.Friend;

@Controller
public class ProfileController {
	
   @Autowired
    private MemberServiceImpl mService;


	@Autowired
	private ProfileServiceImpl pService;
	
    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
    
	@Autowired
    private ChattingRoomService chattingRoomService;
	
    @RequestMapping("profile.do")
    public String selectProfile (@RequestParam("memNo") int memNo, Model model) {	
    	Member m = pService.selectProfile(memNo);
		if(m != null) {
	    	model.addAttribute("m", m);
			return "profile/profile";
		}else {
			model.addAttribute("alertMsg", "조회 실패");
			return "common/mainPage";
		}
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
			return "member/myPageUpdate";
			// out.println("<script>");
			// out.println("alert('수정 성공');");
			// out.println("parent.location.reload();");
			// out.println("</script>");
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
         mv.setViewName("redirect:/threeStar/main.me");
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
			out.println("alert('수정 성공');");
			out.println("parent.location.reload();");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('수정 실패');");
			out.println("history.back();");
			out.println("</script>");
		}
		out.flush();
		return null;
	}
	
	@RequestMapping("profileCheck.do")
	public String myPage() {
		return "member/myPage";
	}
	
	@RequestMapping("insertFriend.do")
	public void insertFriend(Friend friend, Model model, HttpServletResponse response) throws IOException {
	    response.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = response.getWriter();

	    try {
	        int result = pService.insertFriend(friend);

	        if(result > 0) {
	            out.println("<script>");
	            out.println("alert('친구신청 완료');");
	            out.println("parent.location.reload();");
	            out.println("</script>");
	        } else {
	            out.println("<script>");
	            out.println("alert('친구신청 실패');");
	            out.println("parent.location.reload();");
	            out.println("</script>");
	        }

	    } catch(Exception e) {
	        // 예외 발생 시: 친구 신청이 이미 되어 있는 경우
	    	ArrayList<Member> wList = pService.selectWaitingList(friend);
	        
	    	if(!wList.isEmpty()) {
	        	out.println("<script>");
	        	out.println("if(confirm('이미 친구신청이 되어있습니다. 친구신청을 취소하시겠습니까?')) {");
	        	out.println("    location.href='deleteFriend.do?fromMem=" + friend.getFromMem() + "&toMem=" + friend.getToMem() + "';");
	        	out.println("} else {");
	        	out.println("    alert('취소되었습니다.');");
	        	out.println("parent.location.reload();");
	        	out.println("}");
	        	out.println("</script>");
	        }else {
	        	out.println("<script>");
	        	out.println("if(confirm('이미 친구입니다. 친구를 삭제하시겠습니까?')) {");
	        	out.println("    location.href='deleteFriend.do?fromMem=" + friend.getFromMem() + "&toMem=" + friend.getToMem() + "';");
	        	out.println("} else {");
	        	out.println("    alert('취소되었습니다.');");
	        	out.println("parent.location.reload();");
	        	out.println("}");
	        	out.println("</script>");
	        }
	    	
	    }
	}
	
	@RequestMapping("deleteFriend.do")
	public void deleteFriend(Friend friend, HttpServletResponse response) throws IOException {
	    response.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = response.getWriter();
	    
	    int result = pService.deleteFriend(friend);
	    
	    if(result > 0) {
	        out.println("<script>");
	        out.println("alert('친구신청이 취소되었습니다.');");
	        out.println("parent.location.reload();");
	        out.println("</script>");
	    } else {
	        out.println("<script>");
	        out.println("alert('친구 삭제 실패');");
	        out.println("parent.location.reload();");
	        out.println("</script>");
	    }
	}
	
	@RequestMapping("updateFriendName.do")
	public void updateFriendName(Friend friend, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = response.getWriter();
		
	    // 내 memNo는 Friend의 fromMem에 들어있음
		// 내가 누른사람의 memNo는 Friend의 toMem에 들어있음
		int result = pService.updateFriendName(friend);
		if(result > 0) {
			// 성공적으로 이름 수정됨 (친구일때)
	        out.println("<script>");
	        out.println("alert('닉네임 변경이 완료되었습니다.');");
	        out.println("parent.location.reload();");
	        out.println("</script>");
		}else {
			// 이름 수정 실패 (친구가 아닐때)
	        out.println("<script>");
	        out.println("alert('친구가 아니면 닉네임 변경이 불가합니다.');");
	        out.println("parent.location.reload();");
	        out.println("</script>");
		}
	}
	
	@RequestMapping("deleteProfile.do")
	public String deleteProfile(Member p, Model model, HttpSession session, HttpServletResponse response) throws IOException  {
		
		Member loginMember = mService.loginMember(p);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(bcryptPasswordEncoder.matches(p.getMemPwd(), loginMember.getMemPwd())) {
			int result = pService.deleteProfile(p);
			if(result > 0) {
				session.setAttribute("alertMsg", "회원 탈퇴에 성공했습니다.");
				session.removeAttribute("loginMember");
				// return "member/loginForm";
			}else {
				out.println("<script>");
				out.println("alert('회원 탈퇴에 실패했습니다. 다시 시도해 주세요.');");
				out.println("history.back();");
				// out.println("parent.location.reload();");
				out.println("</script>");
			}
			out.println("<script>");
			out.println("parent.location.href='/threeStar/';");
			out.println("</script>");
			out.flush();
			return null;
		}else {
			out.println("<script>");
			out.println("alert('비밀번호가 틀렸습니다. 다시 시도해 주세요.')");
			out.println("history.back();");
			// out.println("parent.location.reload();");
			out.println("</script>");
		}
		out.flush();
		return null;
	}
	
	@RequestMapping("checkProfile.do")
	public String checkProfile() {
		return "member/myPageCheck";
	}
	
	@ResponseBody
	@RequestMapping(value = "profileFriend.do", produces = "application/json; charset=UTF-8")
	public Member selectFriend(Friend friend) {
	    Member m = pService.selectFriend(friend);
	    return m;
	   
   }

}
