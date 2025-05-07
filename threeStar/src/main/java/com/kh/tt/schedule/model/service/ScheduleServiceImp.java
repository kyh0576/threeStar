package com.kh.tt.schedule.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.schedule.model.dao.ScheduleDao;
import com.kh.tt.schedule.model.vo.Schedule;

@Service
public class ScheduleServiceImp implements ScheduleService{

    @Autowired // spring! 나를 injection(주입) 해줘
    private ScheduleDao scDao; // spring이 직접 생성해줘서 new 필요없음 @Repository로 해줬었음
   
    @Autowired // 컨트롤 + 클릭 하면 클래스로 이동됨
    private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Schedule> selectScheduleList(Schedule schedule) {
		return scDao.selectScheduleList(sqlSession, schedule);
	}

	@Override
	public int insertSchedule(Schedule schedule) {
		return scDao.insertSchedule(sqlSession, schedule);
	}

	@Override
	public int deleteSchedule(Schedule schedule) {
		return scDao.deleteSchedule(sqlSession, schedule);
	}

	@Override
	public int updateSchedule(Schedule schedule) {
		return scDao.updateSchedule(sqlSession, schedule);
	}

}
