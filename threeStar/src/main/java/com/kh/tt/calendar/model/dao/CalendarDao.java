package com.kh.tt.calendar.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.calendar.model.vo.Calendar;
import com.kh.tt.member.model.vo.Member;

@Repository
public class CalendarDao {
	
	public int InsertCalendar(SqlSessionTemplate session, Calendar c) {
		return session.insert("calendarMapper.InsertCalendar", c);
	}
	
	public List<Calendar> SelectCalendar(SqlSessionTemplate session, Calendar c) {
		 return session.selectList("calendarMapper.SelectCalendar", c);
		
	}

}
