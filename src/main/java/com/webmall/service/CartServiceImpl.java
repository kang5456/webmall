package com.webmall.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.webmall.domain.CartListVO;
import com.webmall.domain.CartVO;
import com.webmall.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	private CartMapper mapper;
	
	@Override
	public void cartAdd(CartVO vo) {
		
		mapper.cartAdd(vo);
	}

	@Override
	public List<CartListVO> cartList(String cus_id) {
		
		return mapper.cartList(cus_id);
	}

	@Override
	public void cartDel(Integer cart_code) {
		
		mapper.cartDel(cart_code);
	}

	@Override
	public void cartAllDel(String cus_id) {
		
		mapper.cartAllDel(cus_id);
	}

}
