package com.kh.tt.member.model.service;

import com.kh.tt.member.model.vo.Member;

public interface MemberService {
	// 로그인 서비스(select)
    Member loginMember(Member m); // 커맨드 객체 방식

    // 회원가입 서비스(insert)
    int insertMember(Member m);

    // 정보 수정 서비스(update)
    int updateMember(Member m);

    // 회원탈퇴 서비스(update)
    int deleteMember(String userId);

    // 아이디 중복체크 서비스(select)
    int idCheck(String userId);
    
    // 초대코드 유호한지 확인(select)
    int selectClassCode(String classCode);
}
