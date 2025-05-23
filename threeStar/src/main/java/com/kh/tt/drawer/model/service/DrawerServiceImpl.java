package com.kh.tt.drawer.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.tt.drawer.model.dao.DrawerDao;
import com.kh.tt.message.model.vo.Message;

@Service
public class DrawerServiceImpl implements DrawerService {

	@Autowired
	private DrawerDao dDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<Message> selectDrawer(Integer roomId) {
		return dDao.selectDrawer(sqlSession, roomId);
	}
	
}
