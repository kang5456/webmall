package com.webmall.controller;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webmall.domain.CustomerVO;
import com.webmall.domain.EmailDTO;
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
		
	@Inject
	private JavaMailSender mailSender;
	
	// 회원가입 : /customer/join
	@GetMapping("/join")
	public void join() {
		
	}
	
	
	// 회원가입저장
	@PostMapping("/join")
	public String joinOk(CustomerVO vo, RedirectAttributes rttr) throws Exception{
		
		vo.setCus_pw(cryptPassEnc.encode(vo.getCus_pw()));
		vo.setCus_receive(vo.getCus_receive().equals("Y") ? "Y" : "N");
		
		service.join(vo);
		
		return "redirect:/customer/login";
	}
	
	// 아이디 중복체크
	@ResponseBody
	@GetMapping("/checkID")
	public ResponseEntity<String> checkID(@RequestParam("cus_id") String cus_id) throws Exception{
		
		String result = "";
		
		ResponseEntity<String> entity = null;
		
		result = StringUtils.isEmpty(service.checkID(cus_id)) ? "Y" : "N";
		
		entity = new ResponseEntity<String>(result, HttpStatus.OK);
		
		return entity;
	}
	
	// 메일인증 요청
	@ResponseBody
	@GetMapping("/sendMailAuth")
	public ResponseEntity<String> sendMailAuth(@RequestParam("cus_mail") String cus_mail, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		String authCode = makeAuthCode();		
		session.setAttribute("authCode", authCode);
		
		EmailDTO dto = new EmailDTO("webmall","kang5456@gmail.com",cus_mail,"webmall 인증메일",authCode);
		
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			message.addRecipient(RecipientType.TO, new InternetAddress(cus_mail));
			
			message.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(),dto.getSenderName())});
			
			message.setSubject(dto.getSubject(), "utf-8");
			
			message.setText(dto.getMessage(), "utf-8");
			
			mailSender.send(message);
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
		} catch (Exception e) {

			e.printStackTrace();
			
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		} 
		
		
		return entity;
		
	}
	
	
	// 메일인증 확인
	@ResponseBody
	@GetMapping("/mailAuthConfirm")
	public ResponseEntity<String> mailAuthConfirm(@RequestParam("uAuthCode") String uAuthCode, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		String authCode = (String) session.getAttribute("authCode");

		if(authCode.equals(uAuthCode)) {
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
			

		return entity;
		
	}
	
	
	// 회원가입시 메일인증코드 생성
	private String makeAuthCode() {
		
		String authCode = "";
		
		for(int i=0; i<6; i++) {
			authCode += String.valueOf((int)(Math.random() * 9) + 1);
		}
		
		return authCode;
	}


	// 회원수정 폼
	@GetMapping("/modify")
	public void modify() {
		
	}
	
	
	
	// 회원수정 저장
	
	
	
	
	// 회원삭제
	
	
	
	
	// 로그인 폼 /customer/login
	@GetMapping("/login")
	public void login() {
		
	}
	
	
	// 로그인 
	@ResponseBody
	@PostMapping("/login")
	public ResponseEntity<String> login(@RequestParam("cus_id") String cus_id, @RequestParam("cus_pw") String cus_pw,HttpSession session) throws Exception{
		
		String result = "";
		
		ResponseEntity<String> entity = null;
		
		
		CustomerVO vo = service.login(cus_id);
		
		if(vo == null) {
			result = "noId";
		}else {
			if(cryptPassEnc.matches(cus_pw, vo.getCus_pw())) {
				result = "success";
				
				session.setAttribute("loginStatus", vo);
			}else {
				result = "fail";
			}
		}
		
		
		
		entity = new ResponseEntity<String>(result, HttpStatus.OK);
		
		return entity;
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
