package com.kh.tt.calendar.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.calendar.model.dao.CalendarDao;
import com.kh.tt.calendar.model.vo.Calendar;
import com.kh.tt.member.model.vo.Member;

@Service
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	private CalendarDao cDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int InsertCalendar(Calendar c) {
		return cDao.InsertCalendar(sqlSession, c);
	}
	
	@Override
	public List<Calendar> SelectCalendar(Calendar c) {
		return cDao.SelectCalendar(sqlSession, c);
	}
	
}
