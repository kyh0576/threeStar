package com.kh.tt.calendar;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

import com.kh.tt.calendar.controller.CalendarControllerTest;
import com.kh.tt.calendar.model.dao.CalendarDaoTest;
import com.kh.tt.calendar.model.service.CalendarTest;

@RunWith(Suite.class)
@SuiteClasses({ CalendarDaoTest.class, CalendarTest.class, CalendarControllerTest.class })
public class AllTests {

}