package com.kh.tt.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Member {
	private int memNo;
	private String memId;
	private String memPwd;
	private String memName;
	private String email;
	private String phone;
	private String memClassCode;
	private String snsKey;
	private String status;
	private String onlineSt;
	private String adminYN;
	private String profileURL;
	private String toNickname;
	private String memClassName;
}



