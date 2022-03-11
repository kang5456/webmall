package com.webmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webmall.domain.AdminVO;
import com.webmall.service.AdminService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/admin/*")
@Controller
public class AdminController {
	
	private AdminService service;
	
	
	private PasswordEncoder cryptPassEnc;
	
	@GetMapping("/logon")
	public void adminLogForm() {
		
	}
	
	@PostMapping("/logon")
	public String adminLoginallow(String admin_id, String admin_pw, HttpSession session, RedirectAttributes rttr) {
		
		log.info("관리자 아이디: " + admin_id);
		log.info("관리자 패스워드: " + admin_pw);
		
		
		String redirectUrl = "";
		
		AdminVO vo = service.adminLogin(admin_id);
		
		if(!StringUtils.isEmpty(vo)) {
			
			if(cryptPassEnc.matches(admin_pw, vo.getAdmin_pw())) {
				
				session.setAttribute("adminStatus", vo);
				redirectUrl = "/admin/main";
				
			}else {
				
				redirectUrl = "/admin/logon";
				rttr.addFlashAttribute("msg", "failPw");
				
			}
			
		}else {
			
			redirectUrl = "/admin/logon";
			rttr.addFlashAttribute("msg", "failId");
			
		}
		
		return "redirect:" + redirectUrl;
		
	}
	
	// 로그인후 매뉴페이지
	@GetMapping("/main")
	public void main() {
		
	}
	
	
	// 관리자 추가 폼
	@GetMapping("/adminRegister")
	public void  adminRegister() {
		
	}
	
	// 관리자 저장
	@PostMapping("/adminRegister")
	public String  adminRegister(AdminVO vo, RedirectAttributes rttr) {
		
		vo.setAdmin_pw(cryptPassEnc.encode(vo.getAdmin_pw()));
		
		int result = service.adminRegister(vo);
		
		if(result == 1) {
			rttr.addAttribute("msg", "success");
		}else {
			rttr.addAttribute("msg", "fail");
		}
		
		return "redirect:/admin/adminRegister";
		
	}
	
}
