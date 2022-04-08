package com.webmall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.webmall.domain.Criteria;
import com.webmall.domain.PageDTO;
import com.webmall.domain.ProductVO;
import com.webmall.domain.CategoryVO;
import com.webmall.service.UserProductService;
import com.webmall.util.UploadFile;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/product/*")
@Controller
public class UserProductController {

	@Resource(name = "uploadFolder")
	String uploadFolder; // d:\\dev\\upload */

	@Inject // 필드주입
	private UserProductService service;
	
	// 2차카테고리 정보
	@ResponseBody
	@GetMapping(value = "/subCategory/{mainCategoryCode}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("mainCategoryCode") Integer cg_code){
		
		//log.info("1차카테고리" + cg_code);
		
		ResponseEntity<List<CategoryVO>> entity = null;
				
		entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cg_code), HttpStatus.OK);
		
		return entity;
	}
	
	// 2차카테고리에 해당하는 상품리스트
	@GetMapping("/productList")
	public void productList(@ModelAttribute("cri") Criteria cri, @ModelAttribute("cg_code") Integer cg_code, Model model) {
		
		cri.setAmount(3);
		
		List<ProductVO> list = service.getListWithPaging(cg_code, cri);
		
		// 슬래시를 역슬래시로 바꾸는 구문.
		for(int i=0; i<list.size(); i++) {
			ProductVO vo = list.get(i);
			vo.setPdt_uploadpath(vo.getPdt_uploadpath().replace("\\", "/"));
		}
		
		
		int total = service.getTotalCount(cg_code);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("productList", list);
	}
	
	//상품상세설명
	@GetMapping("/productDetail")
	public void productDetail(@RequestParam(value = "type", defaultValue = "Y") String type, @ModelAttribute("cri") Criteria cri, @ModelAttribute("cg_code") Integer cg_code, @RequestParam("pdt_num") Integer pdt_num, Model model) {
		
		ProductVO vo = service.productDetail(pdt_num);
		vo.setPdt_uploadpath(vo.getPdt_uploadpath().replace("\\", "/"));
		
		model.addAttribute("productVO", vo);
		model.addAttribute("type", type);
	}
	
	// 상품리스트 썸네일
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName){
		
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFile.getFileByte(uploadFolder, uploadPath, fileName );
		
		return entity;
	}
	
}
