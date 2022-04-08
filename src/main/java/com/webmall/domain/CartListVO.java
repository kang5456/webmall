package com.webmall.domain;

import lombok.Data;

@Data
public class CartListVO {

	/*
	 	    c.cart_code, c.pdt_num,c.cus_id, c.cart_amount,
		    p.pdt_num, p.cg_first_code, p.cg_code, p.pdt_name, p.pdt_price, p.pdt_discount, p.pdt_publisher, p.pdt_content, 
		    p.pdt_img, p.pdt_amount, p.pdt_buy, p.pdt_date, p.pdt_update,p.pdt_uploadpath
	 */
	
	private Long cart_code;
	private Integer pdt_num;
	private String cus_id;
	private int cart_amount;
	private String pdt_name;
	private String pdt_img;
	private String pdt_uploadpath;
	private int pdt_price;
	private int pdt_discount;
}
