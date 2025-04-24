package com.kh.tt.profile.model.service;

import com.kh.tt.profile.model.vo.Profile;

public interface ProfileService{
	
	// 프로필 아이디, 상태메시지 조회 (select)
	int selectProfile(int memNo);
	
	int selectProfileDetail(int memNo);
	
	//  및 수정(update)
	int updateProfile(Profile p);

}
