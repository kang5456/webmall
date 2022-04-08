package com.webmall.mapper;

import java.util.List;

import com.webmall.domain.CategoryVO;
import com.webmall.domain.Criteria;
import com.webmall.domain.ProductVO;

public interface AdminProductMapper {

	public int product_insert(ProductVO vo);
	
	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cg_code);
	
	public List<ProductVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public ProductVO product_modify(Integer pdt_num);
	
	public int product_modifyOk(ProductVO vo);
	
	public int product_delete(Integer pdt_num);
	
}
