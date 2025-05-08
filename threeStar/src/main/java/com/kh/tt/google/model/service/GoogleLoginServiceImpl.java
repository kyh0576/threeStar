package com.kh.tt.google.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.google.model.dao.GoogleLoginDao;
import com.kh.tt.member.model.vo.Member;

@Service
public class GoogleLoginServiceImpl implements GoogleLoginService{
	
	@Autowired
	private GoogleLoginDao gDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int loginUrlGoogle(Member g) {
		return gDao.loginUrlGoogle(sqlSession, g);
	}
	
	@Override
	public Member loginGoogleMember(Member g) {
		return gDao.loginGoogleMember(sqlSession, g);
	}
	
}
