package com.webmall.service;

import java.util.List;

import com.webmall.domain.CartListVO;
import com.webmall.domain.CartVO;

public interface CartService {

	public void cartAdd(CartVO vo);
	
	public List<CartListVO> cartList(String cus_id);
	
	public void cartDel(Integer cart_code);
	
	public void cartAllDel(String cus_id);
	
}
