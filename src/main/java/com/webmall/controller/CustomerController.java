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
import org.springframework.ui.Model;
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
		
		vo.setCus_receive(!StringUtils.isEmpty(vo.getCus_receive()) ? "Y" : "N");
		
		log.info("MemberVO: " + vo);
		
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
	@GetMapping(value = {"/modify", "/mypage"})
	public void modify(HttpSession session, Model model) {
		
		CustomerVO vo = (CustomerVO) session.getAttribute("loginStatus");
		
		String cus_id = vo.getCus_id();
		
		model.addAttribute(service.login(cus_id));
		
	}
	
	
	
	// 회원수정 저장
	@PostMapping("/modify")
	public String modify(CustomerVO vo, HttpSession session, RedirectAttributes rttr) {
		
		String redirectURL = "";
		
		vo.setCus_receive(!StringUtils.isEmpty(vo.getCus_receive()) ? "Y" : "N");
		
		log.info("회원수정정보: " + vo);
		
		CustomerVO session_vo = (CustomerVO) session.getAttribute("loginStatus");
		
		if(cryptPassEnc.matches(vo.getCus_pw(), session_vo.getCus_pw())) {
			
			service.modify(vo);
						
			redirectURL = "/";
			rttr.addFlashAttribute("msg", "modifyOk");
			
		
		}else {
			redirectURL = "/customer/modify";
			rttr.addFlashAttribute("msg", "modifyFail"); 
		}
		
		
		return "redirect:" + redirectURL;
		
	}
	
	
	// 회원삭제 regDelete
	@ResponseBody
	@PostMapping("/regDelete")
	public ResponseEntity<Integer> regDelete(@RequestParam("cus_pw")String cus_pw, HttpSession session){
		
		ResponseEntity<Integer> entity = null;
		
		CustomerVO vo = (CustomerVO) session.getAttribute("loginStatus");
		
		String cus_id = vo.getCus_id(); 			
		
		entity = new ResponseEntity<Integer>(service.regDelete(cus_id, cryptPassEnc, cus_pw), HttpStatus.OK);
		
		return entity;
		
	}
	
	
	
	// 로그인 폼 /customer/login
	@GetMapping("/login")
	public void login() {
		
	}
	
	
	// 로그인 
	@ResponseBody
	@PostMapping("/login")
	public ResponseEntity<String> login(@RequestParam("cus_id") String cus_id, @RequestParam("cus_pw") String cus_pw, HttpSession session) throws Exception{
		
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
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		session.invalidate();
		
		
		return "redirect:/";
		
	}
	
	// 비번찾기
	@GetMapping("/searchPw")
	public void searchPwform() {
		
	}
	
	
	
	// 비번찾기 기능
	@ResponseBody
	@PostMapping("/searchPw")
	public ResponseEntity<String> searchPwfunction(@RequestParam("cus_mail") String cus_mail) {
		
		ResponseEntity<String> entity = null;		

		if(!StringUtils.isEmpty(service.searchPwByEmail(cus_mail))) {
			
			String tempPw = makeAuthCode();		
			
			EmailDTO dto = new EmailDTO("webmall","kang5456@gmail.com",cus_mail,"webmall 인증메일", tempPw);
			
			MimeMessage message = mailSender.createMimeMessage();
			
			try {
				message.addRecipient(RecipientType.TO, new InternetAddress(cus_mail));
				
				message.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(),dto.getSenderName())});
				
				message.setSubject(dto.getSubject(), "utf-8");
				
				message.setText(dto.getMessage(), "utf-8");
				
				mailSender.send(message);
				
				String encryptPw = cryptPassEnc.encode(tempPw);
				service.changePw(cus_mail, encryptPw);
				
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
				
			}catch(Exception e) {
				
				e.printStackTrace();
				
				entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
				
			}
			
		}else {
			
			entity = new ResponseEntity<String>("noMail", HttpStatus.OK);
			
		}
						
		return entity;
			
		
	}
	
	
	// 비번 변경
	@ResponseBody
	@PostMapping("/changePw")
	public ResponseEntity<String> changePw(@RequestParam("cur_cus_pw")String cur_cus_pw,@RequestParam("change_cus_pw") String change_cus_pw, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		CustomerVO vo = (CustomerVO) session.getAttribute("loginStatus");
		
		String cus_id = vo.getCus_id(); 
		
		String result = service.curPwConFirm(cus_id, cryptPassEnc,cur_cus_pw, cryptPassEnc.encode(change_cus_pw)); 
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
		
	}
	
	
	
	// 7) 아이디 비밀번호 찾기
	@GetMapping("/findinfo")
	public void findinfo() {
		
	}
	
}
