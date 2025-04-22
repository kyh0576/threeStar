package com.kh.tt.profile.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.tt.profile.model.service.ProfileServiceImpl;

@Controller
public class ProfileController {
	
	@Autowired
	private ProfileServiceImpl pService;
	
	@RequestMapping("profile.mo")
	
	

}
