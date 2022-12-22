package com.hello.spring2.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hello.spring2.model.Member;


@Controller
public class AccountController {
	
	@Autowired
	private com.hello.spring2.service.accountService accountService;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@RequestMapping(value = "/account/search_id", method = RequestMethod.GET)
	public String search_id(HttpServletRequest request, Model model,
	        Member member) {
	    
	    
	    return "/account/search_id";
	}
	 
	 
	@RequestMapping(value = "/account/search_pwd", method = RequestMethod.GET)
	public String search_pwd(HttpServletRequest request, Model model,
			Member member) {
	    
	    
	    return "/account/search_pwd";
	}

	
	
	
	@RequestMapping(value = "/account/search_result_id")
	public String search_result_id(HttpServletRequest request, Model model,
	    @RequestParam(required = true, value = "username") String username, 
	    @RequestParam(required = true, value = "email") String email,
	    Member member) {
	 
	 
	try {
	    
		member.setUsername(username);
		member.setEmail(email);
		Member memberSearch = accountService.memberIdSearch(username,email);
	    
	    model.addAttribute("searchVO", memberSearch);
	 
	} catch (Exception e) {
	    System.out.println(e.toString());
	    model.addAttribute("msg", "오류가 발생되었습니다.");
	}
	 
	return "/account/search_result_id";
	}

	
	
	
	
	
	
	
	
	@RequestMapping(value = "/account/search_result_pwd", method = RequestMethod.POST)
	public String search_result_pwd(HttpServletRequest request, Model model,
	    @RequestParam(required = true, value = "username") String username, 
	    @RequestParam(required = true, value = "email") String email,
	    @RequestParam(required = true, value = "id") Long id,
	    String password, 
	    Member member) {
	 
	try {
	    
		member.setUsername(username);
		member.setEmail(email);
		member.setId(id);
	    int memberSearch = accountService.memberPwdCheck(username,email);
	    
	    if(memberSearch == 0) {
	        model.addAttribute("msg", "기입된 정보가 잘못되었습니다. 다시 입력해주세요.");
	        return "/account/search_pwd";
	    }
	    
	    String newPwd = RandomStringUtils.randomAlphanumeric(10);
	    String enpassword = encoder.encode(newPwd);
	    member.setPassword(enpassword);
	    
	    accountService.passwordUpdate(enpassword,username,email,id);
	    
	    model.addAttribute("newPwd", newPwd);
	 
	} catch (Exception e) {
	    System.out.println(e.toString());
	    model.addAttribute("msg", "오류가 발생되었습니다.");
	}
	 
	 
	return "/account/search_result_pwd";
	}

	
	
	
	
	
}
