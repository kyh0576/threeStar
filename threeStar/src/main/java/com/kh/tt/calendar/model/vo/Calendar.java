package com.kh.tt.calendar.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Calendar {
	
	private int calId;
	private int calWriter;
	private String calTitle;
	private String calContent;
	private Date calStart;
	private Date calEnd;

}
