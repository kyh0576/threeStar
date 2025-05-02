package com.kh.tt.member.model.service;

import java.util.ArrayList;

import com.kh.tt.member.model.vo.Classes;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Friend;

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
    
    // 클래스 조회
    ArrayList<Classes> selectClass();
    
    // 클래스별 맴버리스트 조회
    ArrayList<Member> selectMemberList(String classCode);
    
    // 맴버 로그인시 온라인 표시
    int online(Member m);
    
    // 맴버 로그아웃시 오프라인 표시
    int offline(Member m);
    
    // 친구목록 조회
    ArrayList<Member> selectFriendList(int memNo);
    
    // 친구대기중 목록 조회
    ArrayList<Member> selectWaitingList(int memNo);
    
    // 아이디 찾기
    Member findId(Member m);
    
    // 비밀번호 찾기
    Member findPwd(Member m);
    
    // 비밀번호 재설정
    int findUpdatePwd(Member m);
    
    // 친구요청 수락
    int acceptFriend(Friend friend);
    
    // 친구요청 거절
    int rejectFriend(Friend friend);
}
