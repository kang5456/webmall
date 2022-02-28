package com.webmall.mapper;

import com.webmall.domain.CustomerVO;

public interface CustomerMapper {

	public int join(CustomerVO vo);
	
	public String checkID(String cus_id);
	
	public CustomerVO login(String cus_id);
	
}
