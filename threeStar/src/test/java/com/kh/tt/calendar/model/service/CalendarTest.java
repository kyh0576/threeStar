package com.kh.tt.calendar.model.service;

import static org.junit.Assert.*;

import org.junit.Test;

import com.kh.tt.calendar.model.vo.Calendar;

public class CalendarTest {

	@Test
	public void test() {
		int result = 0;
		
		Calendar cal = new Calendar();
		result = cal.getCalId().sum(1, 19);
		assertEquals(20, result);
	}

}
