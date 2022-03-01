package com.webmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

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

	@Override
	public int modify(CustomerVO vo) {
		
		return mapper.modify(vo);
	}

	@Override
	public String searchPwByEmail(String cus_mail) {
		
		return mapper.searchPwByEmail(cus_mail);
	}

	@Override
	public int changePw(String cus_mail, String cus_pw) {
		
		return mapper.changePw(cus_mail, cus_pw);
	}

	@Override
	public String curPwConFirm(String cus_id,PasswordEncoder cryptPassEnc, String cur_cus_pw, String change_cus_pw) {
		
		String result = "noPw";
		
		if(cryptPassEnc.matches(cur_cus_pw, mapper.curPwConFirm(cus_id))){
			mapper.changeNewPw(cus_id, change_cus_pw);
			result = "success";
		}
		
		return result;
	}

	@Override
	public int regDelete(String cus_id,PasswordEncoder cryptPassEnc, String cus_pw) {
		
		int count = 0;
		
		if(cryptPassEnc.matches(cus_pw, mapper.curPwConFirm(cus_id))){
			count = mapper.regDelete(cus_id);
		}
		
		return count;
	}

}
