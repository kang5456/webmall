package com.webmall.controller;



import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webmall.domain.CategoryVO;
import com.webmall.domain.Criteria;
import com.webmall.domain.PageDTO;
import com.webmall.domain.ProductVO;
import com.webmall.service.AdminProductService;
import com.webmall.util.UploadFile;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/admin/product/*")
@Controller
public class AdminProductController {

	@Resource(name = "uploadFolder")
	String uploadFolder;
	
	private AdminProductService service;
	
	// 상품 등록 폼
	@GetMapping("/productInsert")
	public void product_insert(Model model) {
		
		model.addAttribute("mainCategory", service.mainCategory());
		
	}
	
	// 2차 카테고리 정보
	@ResponseBody
	@GetMapping(value = "/subCategory/{mainCategoryCode}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("mainCategoryCode") Integer cg_code){
		
		ResponseEntity<List<CategoryVO>> entity = null;		
			
		entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cg_code), HttpStatus.OK);		
		
		return entity;
		
	}
	
	// CKEditor 상품설명 이미지
	@PostMapping("/editor/imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,@RequestParam MultipartFile upload) {
		
		/*
		 CKEditor 파일업로드 1)파일업로드 작업 2) 업로드된 파일정보를 브라우저에게 보내야 한다. 
		  
		 */
		
		
		// 클라이언트로부터 전송되어 온 파일을 업로드폴더에 복사(생성)작업
		OutputStream out = null;
		
		// 업로드된 파일정보를 브라우저에게 보내는 작업
		PrintWriter printWriter = null;
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			// 클라이언트에서 전송해 온 파일명을 포함하여, 실제 업로드되는 경로생성
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName;
			
			log.info("업로드폴더 경로: " + uploadPath);
			
			out = new FileOutputStream(new File(uploadPath)); // 0byte의 빈 파일생성
			
			// 파일에 내용이 채워짐.
			out.write(bytes);
			out.flush();
			
			/*======================================================================*/
			
			
			String callback = request.getParameter("CKEditorFuncNum");
			
			log.info(callback);
			
			printWriter = response.getWriter();
			
			// <resources mapping="/upload/**" location="/resources/upload/" />
			String fileUrl = "/upload/" + fileName;
			
			printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction("
								+ callback
								+ ",'"
								+ fileUrl
								+ "','이미지를 업로드 하였습니다.'"
								+ ")</script>");
			printWriter.flush();
			
		
		
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
			if(out != null) out.close();
			if(printWriter != null) printWriter.close();
			}catch(Exception ex) {
				ex.printStackTrace();
			}
			
		}
		
		//return;
		
	}
	
	
	
	// 상품 등록 저장
	@PostMapping("/productInsert")
	public String product_insert(ProductVO vo, RedirectAttributes rttr) {
		
		log.info("상품정보" + vo);
		
		// 파일 업로드
		vo.setPdt_img(UploadFile.uploadFile(uploadFolder, vo.getUpload()));
		vo.setPdt_uploadpath(UploadFile.getFolder());
		
		// 상품정보 저장
		service.product_insert(vo);
		
		rttr.addFlashAttribute("msg", "insertOk");
		
		return "redirect:/admin/product/productList";
		
	}
	
	
	// 상품 리스트
	@GetMapping("/productList")
	public void product_list(Criteria cri, Model model) {
		
		cri.setAmount(2);
		List<ProductVO> list = service.getListWithPaging(cri);
		
		for(int i=0; i<list.size(); i++) {
			ProductVO vo = list.get(i);
			vo.setPdt_uploadpath(vo.getPdt_uploadpath().replace("\\", "/"));
		}
		
		int total = service.getTotalCount(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("productList", list);
		
	}
	
	
	// 상품 수정 폼
	@GetMapping("/productModify")
	public void product_modify(@RequestParam("pdt_num") Integer pdt_num, @ModelAttribute("cri") Criteria cri, Model model) {
		
		ProductVO vo = service.product_modify(pdt_num);
		vo.setPdt_uploadpath(vo.getPdt_uploadpath().replace("\\", "/"));
		model.addAttribute("productVO", vo);
		
		
		model.addAttribute("mainCategory", service.mainCategory());
		
		model.addAttribute("subCategory", service.subCategory(vo.getCg_first_code()));
		
	}
	
	
	
	// 상품 수정 저장
	@PostMapping("/productModify")
	public String product_modify(Criteria cri, ProductVO vo, RedirectAttributes rttr) {
		
		if(vo.getUpload().getSize() > 0) {
				
				UploadFile.deleteFile(uploadFolder, vo.getPdt_uploadpath(), vo.getPdt_img());
			
				vo.setPdt_img(UploadFile.uploadFile(uploadFolder, vo.getUpload()));
				vo.setPdt_uploadpath(UploadFile.getFolder()); // 날짜폴더명
			}
			
			service.product_modifyOk(vo);
			
			rttr.addFlashAttribute("msg", "modifyOk"); 
			
			rttr.addAttribute("pageNum", cri.getPageNum()); 
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
			
			return "redirect:/admin/product/productList";
		}
		
	
	
	// 상품리스트 썸네일
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName){
		
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFile.getFileByte(uploadFolder, uploadPath, fileName );
		
		return entity;
	}
	
	
	
	// 상품 삭제
	
	
	
	
	// 상품 선택 삭제 pdt_uploadpathArr   400에러발생되면. 클라이언트에서 보낸 데이타를 스프링에서 받지 못하는 상태. (중요)ajax로 사용시 파라미터를 [] 로 사용해야 한다.
	@ResponseBody
	@PostMapping("/checkDelete")
	public ResponseEntity<String> checkDelete(@RequestParam("pdt_numArr[]") List<Integer> pdt_numArr,
											  @RequestParam("pdt_imgArr[]") List<String> pdt_imgArr,
											  @RequestParam("pdt_uploadpathArr[]") List<String> pdt_uploadpathArr){
		
		ResponseEntity<String> entity = null;
		
		try {
			for(int i=0; i<pdt_numArr.size(); i++) {
				// 상품이미지 삭제
				UploadFile.deleteFile(uploadFolder, pdt_uploadpathArr.get(i), pdt_imgArr.get(i));
				
				// 상품테이블 삭제작업
				service.product_delete(pdt_numArr.get(i));
			}
			
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
			
		} catch (Exception e) {

			e.printStackTrace();
			entity = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
		
	}
	
	
	// 상품 개별삭제
	@PostMapping("/productDelete")
	public String productDelete(Criteria cri, @RequestParam("pdt_num") Integer pdt_num, RedirectAttributes rttr ) {
		
		System.out.println("상품삭제: " + cri);
		System.out.println("상품코드: " + pdt_num);
		
		service.product_delete(pdt_num);
		
		rttr.addFlashAttribute("msg", "deleteOk"); // jsp에서 참조.
		
		rttr.addAttribute("pageNum", cri.getPageNum()); // 주소에서 호출되는 메서드 파라미터 참조.
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/product/productList";
	}
	
	
}
