package com.webmall.domain;

import lombok.Data;

@Data
public class CartVO {

	// cart_code, pdt_num, cus_id, cart_amount
	private Long cart_code;
	private Integer pdt_num;
	private String cus_id;
	private int cart_amount;
}
