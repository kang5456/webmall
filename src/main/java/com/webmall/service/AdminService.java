package com.webmall.service;

import com.webmall.domain.AdminVO;

public interface AdminService {

	public AdminVO adminLogin(String admin_id);
	
	public int adminRegister(AdminVO vo);
	
}
