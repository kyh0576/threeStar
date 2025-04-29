package com.kh.tt.profile.model.service;

import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Profile;

public interface ProfileService{
	
	// 프로필 아이디, 상태메시지 조회 (select)
	int selectProfile(int memNo);
	
    Member loginMember(Member p); // 커맨드 객체 방식
    
    Member detailProfile(Member p);
	
	//  및 수정(update)
	int updateProfile(Member p);
	
	int deleteProfile(Member p);
	
	

}
