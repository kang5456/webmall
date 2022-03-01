package com.webmall.domain;

import lombok.Data;

@Data
public class CustomerVO {

	// cus_id, cus_name, cus_pw, cus_mail, cus_phone,cus_zipcode, cus_addr, cus_deaddr
	
	private String cus_id;
	private String cus_name;
	private String cus_pw;
	private String cus_mail;
	private String cus_receive;
	private String cus_phone;
	
}
