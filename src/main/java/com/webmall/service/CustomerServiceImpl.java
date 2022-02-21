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

}
