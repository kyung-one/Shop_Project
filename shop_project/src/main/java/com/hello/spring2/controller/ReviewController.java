package com.hello.spring2.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hello.spring2.config.auth.PrincipalUser;
import com.hello.spring2.model.BoardReview;
import com.hello.spring2.model.Product;
import com.hello.spring2.service.BoardReviewService;
import com.hello.spring2.service.CommentService;


@Controller
@RestController
@RequestMapping("/reply/*")
public class ReviewController {

	@Autowired
	public BoardReviewService boardReviewservice;
	
	
	//댓글추가
	@PostMapping("insert/{num}")
	public ResponseEntity commentInsert(@PathVariable Long num, @RequestBody BoardReview boardreview,Model model,
			@AuthenticationPrincipal PrincipalUser principal) {
				
		Product p = new Product();
		p.setProductid(num);  //bnum을 의미
		boardreview.setProduct(p);
		
		//PrincipalUser p =(PrincipalUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//comment.setUser(p.getUser());
		
		//boardreview.setMember(principal.getUser());
		
		boardreview.setMember(principal.getMember());
		 boardReviewservice.insert(boardreview);
		
		return new ResponseEntity<String>("success",HttpStatus.OK);
		
	}
	
	//전체보기
	@GetMapping("list/{num}")
	public List<BoardReview> list(@PathVariable Long num,Model model){
		System.out.println("num:"+ num);
		List<BoardReview> plist = boardReviewservice.list(num);
		
		model.addAttribute("reviews", plist);
		return  plist;
	}
	
	
	@DeleteMapping("delete/{reviewnum}")
	public Long delete(@PathVariable Long reviewnum) {
		boardReviewservice.delete(reviewnum);
		return reviewnum;
	}
	
	
	
}
