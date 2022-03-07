package com.webmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webmall.domain.AdminVO;
import com.webmall.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;
	
	@Override
	public AdminVO adminLogin(String admin_id) {
		
		return mapper.adminLogin(admin_id);
	}

}
