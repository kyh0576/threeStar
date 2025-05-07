package com.kh.tt.schedule.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.tt.schedule.model.vo.Schedule;

public interface ScheduleService {
	
	// 스케줄 조회
	ArrayList<Schedule> selectScheduleList(Schedule schedule);
	
	// 스케줄 추가
	int insertSchedule(Schedule schedule);
	
	// 스케줄 삭제
	int deleteSchedule(Schedule schedule);
	
	// 스케줄 수정
	int updateSchedule(Schedule schedule);
}
