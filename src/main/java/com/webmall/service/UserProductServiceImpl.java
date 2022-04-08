package com.webmall.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.webmall.domain.CategoryVO;
import com.webmall.domain.Criteria;
import com.webmall.domain.ProductVO;
import com.webmall.mapper.UserProductMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class UserProductServiceImpl implements UserProductService {

	@Inject
	private UserProductMapper mapper;
	
	@Override
	public List<CategoryVO> mainCategory() {
		
		return mapper.mainCategory();
	}

	@Override
	public List<CategoryVO> subCategory(Integer cg_code) {
		
		return mapper.subCategory(cg_code);
	}

	@Override
	public List<ProductVO> getListWithPaging(Integer cg_code, Criteria cri) {
		
		return mapper.getListWithPaging(cg_code, cri);
	}

	@Override
	public int getTotalCount(Integer cg_code) {
		
		return mapper.getTotalCount(cg_code);
	}

	@Override
	public ProductVO productDetail(Integer pdt_num) {
		
		return mapper.productDetail(pdt_num);
	}

}
