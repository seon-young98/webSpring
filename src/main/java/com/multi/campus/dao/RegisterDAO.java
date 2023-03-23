package com.multi.campus.dao;

import com.multi.campus.dto.RegisterDTO;

public interface RegisterDAO {
	//로그인
	public RegisterDTO loginOk(String userid, String userpwd); 
}
