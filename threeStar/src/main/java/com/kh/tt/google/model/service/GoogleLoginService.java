package com.kh.tt.google.model.service;

import com.kh.tt.member.model.vo.Member;

public interface GoogleLoginService {
	
	public int loginUrlGoogle(Member g);
	
	public Member loginGoogleMember(Member g);

}
