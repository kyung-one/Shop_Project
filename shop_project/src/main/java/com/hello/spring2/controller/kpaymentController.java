package com.hello.spring2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hello.spring2.service.KakaoPay;

import lombok.Setter;
import lombok.extern.java.Log;

@Log
@Controller
public class kpaymentController {
	
	
	   @Autowired
	    private KakaoPay kakaopay;
	    
	   @GetMapping("/payment")
		public String payment() {
			return "/kakao/payment";
		}
	   

	   
	   @GetMapping("/kakaoPayCancel")
		public String kakaoPayCancel() {
			return "/kakao/kakaoPayCancel";
		}
	   @GetMapping("/kakaoPaySuccessFail")
		public String kakaoPaySuccessFail() {
			return "/kakao/kakaoPaySuccessFail";
		}
	   
	   
	 
	   
	    @GetMapping("/kakaoPay")
	    public void kakaoPayGet() {
	        
	    }
	    
	    @PostMapping("/kakaoPay")
	    public String kakaoPay() {
	        log.info("kakaoPay post............................................");
	        
	        return "redirect:" + kakaopay.kakaoPayReady();
	 
	    }
	    
	    @GetMapping("/kakaoPaySuccess")
	    public void kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model) {
	        log.info("kakaoPaySuccess get............................................");
	        log.info("kakaoPaySuccess pg_token : " + pg_token);
	        
	        model.addAttribute("info", kakaopay.kakaoPayInfo(pg_token));
	        
	    }

	    
	    
	    
	    
}
