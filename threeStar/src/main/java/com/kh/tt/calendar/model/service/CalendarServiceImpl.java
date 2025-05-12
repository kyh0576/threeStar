package com.kh.tt.calendar.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.calendar.model.dao.CalendarDao;
import com.kh.tt.member.model.vo.Member;

@Service
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	private CalendarDao cDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int InsertCalendar(Member c) {
		return cDao.InsertCalendar(sqlSession, c);
	}

}
