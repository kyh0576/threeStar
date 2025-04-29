package com.kh.tt.profile.model.service;

import java.util.ArrayList;

import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Friend;
import com.kh.tt.profile.model.vo.Profile;

public interface ProfileService{
	
	// 프로필 아이디, 상태메시지 조회 (select)
	Member selectProfile(String memId);
	
    Member loginMember(Member p); // 커맨드 객체 방식
    
    Member detailProfile(Member p);
	
	//  및 수정(update)
	int updateProfile(Member p);
	
	// 친구 신청
	int insertFriend(Friend friend);

	// 친구 삭제
	int deleteFriend(Friend friend);
	
	// 친구 신청한 목록
	ArrayList<Member> selectWaitingList(Friend friend);
}
