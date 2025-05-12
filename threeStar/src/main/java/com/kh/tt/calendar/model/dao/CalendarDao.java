package com.kh.tt.calendar.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.member.model.vo.Member;

@Repository
public class CalendarDao {
	
	public int InsertCalendar(SqlSessionTemplate session, Member c) {
		return session.insert("calendarMapper.InsertCalendar");
	}

}
