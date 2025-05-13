package com.kh.tt.calendar.model.service;

import java.util.List;

import com.kh.tt.calendar.model.vo.Calendar;
import com.kh.tt.member.model.vo.Member;

public interface CalendarService {
	
	public int InsertCalendar(Calendar c);
	
	public List<Calendar> SelectCalendar(Calendar c);
	
	public int updateCalendar(Calendar c);
	
	public int deleteCalendar(Calendar c);
	
}
