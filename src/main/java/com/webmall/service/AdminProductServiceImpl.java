package com.webmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webmall.domain.CategoryVO;
import com.webmall.domain.Criteria;
import com.webmall.domain.ProductVO;
import com.webmall.mapper.AdminProductMapper;

import lombok.Setter;

@Service
public class AdminProductServiceImpl implements AdminProductService {

	@Setter(onMethod_ = @Autowired)
	private AdminProductMapper mapper;
	
	@Override
	public int product_insert(ProductVO vo) {
		
		return mapper.product_insert(vo);
	}

	@Override
	public List<CategoryVO> mainCategory() {
		
		return mapper.mainCategory();
	}

	@Override
	public List<CategoryVO> subCategory(Integer cg_code) {
		
		return mapper.subCategory(cg_code);
	}

	@Override
	public List<ProductVO> getListWithPaging(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public ProductVO product_modify(Integer pdt_num) {
		
		return mapper.product_modify(pdt_num);
	}

	@Override
	public int product_modifyOk(ProductVO vo) {
		
		return mapper.product_modifyOk(vo);
	}

	@Override
	public int product_delete(Integer pdt_num) {
		
		return mapper.product_delete(pdt_num);
	}

}
