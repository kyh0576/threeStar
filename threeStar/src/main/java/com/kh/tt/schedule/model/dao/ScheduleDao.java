package com.kh.tt.schedule.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.schedule.model.vo.Schedule;

@Repository
public class ScheduleDao {

	public ArrayList<Schedule> selectScheduleList(SqlSessionTemplate sqlSession, Schedule schedule) {
	    return (ArrayList)sqlSession.selectList("scheduleMapper.selectScheduleList", schedule);
	}

	public int insertSchedule(SqlSessionTemplate sqlSession, Schedule schedule) {
		return sqlSession.insert("scheduleMapper.insertSchedule", schedule);
	}

	public int deleteSchedule(SqlSessionTemplate sqlSession, Schedule schedule) {
		return sqlSession.delete("scheduleMapper.deleteSchedule", schedule);
	}

	public int updateSchedule(SqlSessionTemplate sqlSession, Schedule schedule) {
		return sqlSession.update("scheduleMapper.updateSchedule", schedule);
	}
	
}
