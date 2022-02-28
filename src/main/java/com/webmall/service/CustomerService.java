package com.webmall.service;

import com.webmall.domain.CustomerVO;

public interface CustomerService {

	public int join(CustomerVO vo);
	
	public String checkID(String cus_id);
	
	public CustomerVO login(String cus_id);
	
}
