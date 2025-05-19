package com.kh.tt.calendar.model.dao;

import static org.junit.Assert.*;

import java.util.Arrays;
import java.util.Collection;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import com.kh.tt.calendar.model.vo.Calendar;

@RunWith(Parameterized.class)
public class CalendarDaoTest {
	private int expected;
	private int value;

	@Parameters
	public static Collection getParameters() {
		return Arrays.asList(new Object[][] {
			{55, 54},
			{-210, -211}
		});
	}
	
	public CalendarDaoTest(int expected, int value) {
		this.expected = expected;
		this.value = value;
	}
	
	@Test
	public void testSum() {
		Calendar cal = new Calendar();
		int result = cal.getCalId().sum(1, value);
		assertEquals(expected, result);
	}

}

