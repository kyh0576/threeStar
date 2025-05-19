package com.kh.tt.calendar.controller;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import com.kh.tt.calendar.model.vo.Calendar;

public class CalendarControllerTest {
	
	private Calendar cal;
	
	@Before
	public void setUp() {
		cal = new Calendar();
	}
	
	@Test
	public void testSum1() {
		int result = cal.getCalId().sum(10, 5);
		assertEquals(15, result);
	}
	
	@Test
	public void testSum2() {
		int result = cal.getCalId().sum(1, 0);
		assertEquals(1, result);
	}
}

