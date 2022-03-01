package com.webmall.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.webmall.domain.CustomerVO;

public interface CustomerService {

	public int join(CustomerVO vo);
	
	public String checkID(String cus_id);
	
	public CustomerVO login(String cus_id);
	
	public int modify(CustomerVO vo);
	
	public String searchPwByEmail(String cus_mail);
	
	public int changePw(String cus_mail, String cus_pw);
	
	public String curPwConFirm(String cus_id, PasswordEncoder cryptPassEnc ,String cur_cus_pw,String change_cus_pw);
	
	public int regDelete(String cus_id,PasswordEncoder cryptPassEnc, String cus_pw);
	
}
