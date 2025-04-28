package com.kh.tt.message.model.vo;

import java.sql.Date;

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
public class Message {
	
	private int messageNo;
	private String messageContent;
	private Date createDate;
	private Date sendTime;
	private String originName;
	private String changeName;
	private int msChatId;
    private int msMemNo;

}