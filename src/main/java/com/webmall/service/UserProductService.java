package com.webmall.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.webmall.domain.CategoryVO;
import com.webmall.domain.Criteria;
import com.webmall.domain.ProductVO;

public interface UserProductService {

	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cg_code);
	
	public List<ProductVO> getListWithPaging(Integer cg_code, Criteria cri);
	
	public int getTotalCount(Integer cg_code);
	
	public ProductVO productDetail(Integer pdt_num);
}
