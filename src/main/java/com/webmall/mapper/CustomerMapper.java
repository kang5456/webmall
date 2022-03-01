package com.webmall.mapper;

import org.apache.ibatis.annotations.Param;

import com.webmall.domain.CustomerVO;

public interface CustomerMapper {

	public int join(CustomerVO vo);
	
	public String checkID(String cus_id);
	
	public CustomerVO login(String cus_id);
	
	public int modify(CustomerVO vo);
	
	public String searchPwByEmail(String cus_mail);
	
	public int changePw(@Param("cus_mail")String cus_mail,@Param("cus_pw") String cus_pw);
	
	public String curPwConFirm(String cus_id);
	
	public int changeNewPw(@Param("cus_id") String cus_id,@Param("change_cus_pw") String change_cus_pw);
	
	public int regDelete(String cus_id);
	
}
