package com.kh.tt.schedule.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.tt.schedule.model.service.ScheduleServiceImp;
import com.kh.tt.schedule.model.vo.Schedule;

@Controller
public class ScheduleController {

    @Autowired // DI(Dependency Injection) 특징
    private ScheduleServiceImp scService;
	
	@RequestMapping(value = "selectScheduleList.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ArrayList<Schedule> selectScheduleList(Schedule schedule) {
		System.out.println("스케줄 : " + schedule);
	    ArrayList<Schedule> scList = scService.selectScheduleList(schedule); // friend = 'N'만 조회
	    System.out.println(scList);
	    return scList;
	}
}
