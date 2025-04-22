package com.kh.tt.profile.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.profile.model.dao.ProfileDao;
import com.kh.tt.profile.model.vo.Profile;

@Service
public class ProfileServiceImpl implements ProfileService {
	
	@Autowired
	private ProfileDao pDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Profile selectProfile(int memNo) {
		return pDao.selectProfile(sqlSession, memNo);
	}
	
	@Override
	public Profile selectProfileDetail(String memId) {
		return pDao.selectProfileDetail(sqlSession, memId);
	}
	
	@Override
	public int updateProfile(Profile p) {
		return pDao.updateProfile(sqlSession, p);
	}
	
	

	
	
}
