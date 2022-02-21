package com.webmall.controller;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webmall.domain.CustomerVO;
import com.webmall.service.CustomerService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/customer/*")
@Controller
public class CustomerController {

	@Inject
	private PasswordEncoder cryptPassEnc;
	
	@Inject
	private CustomerService service;
		
	
	// 회원가입 : /customer/join
	@GetMapping("/join")
	public void join() {
		
	}
	
	
	// 회원가입저장
	@PostMapping("/join")
	public String joinOk(CustomerVO vo, RedirectAttributes rttr) throws Exception{
		
		vo.setCus_pw(cryptPassEnc.encode(vo.getCus_pw()));
		vo.setCus_mail(vo.getCus_mail().equals("Y") ? "Y" : "N");
		
		service.join(vo);
		
		return "redirect:/customer/login";
	}
	
	// 아이디 중복체크
	
	
	
	
	// 회원수정 폼
	@GetMapping("/modify")
	public void modify() {
		
	}
	
	
	
	// 회원수정 저장
	
	
	
	
	// 회원삭제
	
	
	
	
	// 로그인 /customer/login
	@GetMapping("/login")
	public void login() {
		
	}
	
	
	
	// 로그아웃
	
	
	
	
	// 마이페이지
	@GetMapping("/mypage")
	public void mypage() {
		
	}
	
	
	
	
	// 7) 아이디 비밀번호 찾기
	@GetMapping("/findinfo")
	public void findinfo() {
		
	}
	
}
