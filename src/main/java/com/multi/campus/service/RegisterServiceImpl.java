package com.multi.campus.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.campus.dao.RegisterDAO;
import com.multi.campus.dto.RegisterDTO;

@Service
public class RegisterServiceImpl implements RegisterService {
	//객체 생성
	@Inject
	RegisterDAO dao;
	
	@Override
	public RegisterDTO loginOk(String userid, String userpwd) {
		return dao.loginOk(userid, userpwd);
	}

	

}
