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
	public int selectProfile(int memNo) {
		int result = pDao.selectProfile(sqlSession, memNo);
		System.out.println("service : " + result);
		return result;
	}
	
	@Override
	public int selectProfileDetail(int memNo) {
		return pDao.selectProfileDetail(sqlSession, memNo);
	}
	
	@Override
	public int updateProfile(Profile p) {
		return pDao.updateProfile(sqlSession, p);
	}
	
	

	
	
}
