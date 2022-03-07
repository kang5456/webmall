package com.webmall.controller;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String adminLoginallow(String admin_id) {
		
		
		AdminVO vo = service.adminLogin(admin_id);
		
		return "redirect:/admin/main";
		
	}
	
	@GetMapping("/main")
	public void main() {
		
	}
	
}
