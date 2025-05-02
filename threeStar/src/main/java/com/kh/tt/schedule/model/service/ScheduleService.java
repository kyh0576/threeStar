package com.kh.tt.schedule.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.tt.schedule.model.vo.Schedule;

public interface ScheduleService {
	
	// 스케줄 조회
	ArrayList<Schedule> selectScheduleList(Schedule schedule);
}
