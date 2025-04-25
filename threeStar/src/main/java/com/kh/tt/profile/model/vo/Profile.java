package com.kh.tt.profile.model.vo;

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

public class Profile {
	
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

}
