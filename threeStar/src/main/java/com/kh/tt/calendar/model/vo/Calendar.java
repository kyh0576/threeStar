package com.kh.tt.calendar.model.vo;

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
	
	private Integer calId;
	private Integer calWriter;
	private String calTitle;
	private String calContent;
	private String calStart;
	private String calEnd;

}
