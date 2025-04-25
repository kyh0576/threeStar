package com.kh.tt.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.tt.member.model.service.MemberServiceImpl;
import com.kh.tt.member.model.vo.Classes;
import com.kh.tt.member.model.vo.Member;

@Controller
public class MemberController {
	@Autowired // DI(Dependency Injection) 특징
    private MemberServiceImpl mService; // spring이 대신 생성해주므로 new 필요없 (하지만 아래에 사항이 충족돼야함)

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
    // 1. MemberServiceImpl => 스프링의 빈으로 등록돼있어야함
    // 2. Autowired 타입으로 어노테이션 등록돼있어야함 (안돼있으면 주입 injection이 안됨)
    // => spring이 자동으로 new로 생성해줌
    
    
    @RequestMapping("loginForm.me")
    public String loginForm() {
    	return "member/loginForm";
    }
    
    @RequestMapping("login.me")
	public ModelAndView loginMember(Member m, HttpSession session, ModelAndView mv) {
		
		Member loginMember = mService.loginMember(m);
		ArrayList<Classes> cList = mService.selectClass();
		
		if(loginMember != null && bcryptPasswordEncoder.matches(m.getMemPwd(), loginMember.getMemPwd())) {
			// 로그인 성공
			mService.online(m);
			session.setAttribute("loginMember", loginMember);
			session.setAttribute("cList", cList);
			mv.setViewName("redirect:/main.me");
		}else {
			// 로그인 실패
			mv.addObject("alertMsg", "로그인 실패!");
			mv.setViewName("member/loginForm");
		}
		
		return mv;
	}
	
    @RequestMapping("main.me")
    public String mainPage() {
        return "common/mainPage";
    }
    
    // 메인페이지 연동되면 로그아웃 만들거임
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session, Member m) {
		System.out.println("🔍 memId 넘어옴? => " + m.getMemId()); // ⭐ 로그 찍기
		
		int result = mService.offline(m); // 상태 업데이트
		
		System.out.println("오프라인 처리 결과: " + result);
		
		session.invalidate(); // 프로그램에 설정돼있는 모든 세션 무력화
		return "redirect:/";
	}
	
	@RequestMapping("signinForm.me")
	public String enrollForm() {
		return "member/signinForm";
	}
	
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {
		System.out.println(m);
		// 1. 한글 깨짐 (post 방식) => 스프링에서 제공하는 인코딩 필터 등록 => web.xml에 filter 등록
		// 2. 나이를 입력하지 않았을경우 "" 빈문자열이 넘어오는데 int형 필드에 담을 수 없어서 400 에러 발생 
		//    7이라도 들어있으면 웹사이트에서 들어오는 정보는 다 String로 오니까 "7"로 와도 자동형변환으로 7로 int에 들어갈텐데 ""로와서 문제
		//    => Member 클래스의 age 필드를 int형 --> String형으로 변경
		// 3. 비밀번호가 사용자가 입력한 있는 그대로의 평문
		//    => Bcrypt 방식의 암호화를 통해서 암호문으로 변경
		//    => 1) 스프링 시큐리티 모듈에서 제공 (라이브러리 추가 pom.xml)
		//    => 2) BcryptPasswordEncoder 라는 클래스를 빈으로 등록(spring-security.xml 파일에) (우리가 만든게 아니라 수정이 불가하므로 xml 써야함)
		//    => 3) web.xml에 spring-security.xml 파일을 pre-loading(서버가 처음 켜지면 읽는거)을 할 수 있도록 작성
		
		// 암호화 작업(암호문을 만들어내는 과정)
		String encPwd = bcryptPasswordEncoder.encode(m.getMemPwd());
		
		m.setMemPwd(encPwd); // Member 객체의 userPwd에 평문이 아닌 암호문으로 변경
		
		
		
		int classCode = mService.selectClassCode(m.getMemClassCode());
		System.out.println(classCode);
		if(classCode > 0) { // 유효한 초대코드를 입력됐을때
			System.out.println("클래스 코드가 유효합니다.");
			
			int result = mService.insertMember(m);
			
			if(result > 0) { // 성공 => 메인페이지 url 재요청
				model.addAttribute("alertMsg", "회원가입 성공");
				System.out.println("회원가입 성공");
				//session.setAttribute("alertMsg", "성공적으로 회원가입 되었습니다.");
				return "member/loginForm";
				
			}else { // 실패 => 에러문구 담아서 에러페이지
				System.out.println("회원가입 실패");
				//model.addAttribute("errorMsg", "회원가입실패");
				return "common/errorPage";
			}
		}else { // 유효하지 않는 초대코드를 입력했을때
			model.addAttribute("alertMsg", "초대코드가 다릅니다. 다시 입력해 주세요");
			System.out.println("초대코드가 다릅니다.");
			return "member/signinForm";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "selectMemberList.me", produces = "application/json; charset=UTF-8")
	public ArrayList<Member> selectMemberList(String classCode, HttpSession session) {
	    System.out.println("받아온 classCode: " + classCode);
	    
	    ArrayList<Member> mList = mService.selectMemberList(classCode);
	    System.out.println("받아온 mList: " + mList);  // ⭐ null 인지 확인!

	    return mList;
	}
	
	@ResponseBody
	@RequestMapping(value = "idCheck.me", produces = "application/json; charset=UTF-8")
	public int idCheck(String userId) {
		
		int result =  mService.idCheck(userId);

		return result;
	}
}
