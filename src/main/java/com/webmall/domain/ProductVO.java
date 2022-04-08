package com.webmall.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {

	// pdt_num,cg_first_code, cg_code, pdt_name, pdt_price, pdt_discount, pdt_content, pdt_img, pdt_amount, pdt_buy, pdt_date, pdt_update
	
	private Integer pdt_num;	
	private Integer cg_first_code;
	private Integer cg_code;
	private String pdt_name;
	private int pdt_price;
	private int pdt_discount;
	private String pdt_publisher;
	private String pdt_content;
	private String pdt_img;
	private String pdt_uploadpath;
	private int pdt_amount;
	private String pdt_buy;
	private Date pdt_date;
	private Date pdt_update;
	
	private MultipartFile upload;
}
