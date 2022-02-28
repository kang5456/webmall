package com.webmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webmall.domain.CustomerVO;
import com.webmall.mapper.CustomerMapper;

import lombok.Setter;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Setter(onMethod_ = @Autowired)
	private CustomerMapper mapper;
	
	@Override
	public int join(CustomerVO vo) {
		
		return mapper.join(vo);
	}

	@Override
	public String checkID(String cus_id) {
		
		return mapper.checkID(cus_id);
	}

	@Override
	public CustomerVO login(String cus_id) {
		
		return mapper.login(cus_id);
	}

}
