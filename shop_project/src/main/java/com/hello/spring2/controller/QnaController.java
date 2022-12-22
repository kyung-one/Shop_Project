package com.hello.spring2.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hello.spring2.config.auth.PrincipalUser;
import com.hello.spring2.model.BoardQna;
import com.hello.spring2.model.Product;
import com.hello.spring2.service.BoardQnaService;




@Controller
public class QnaController {
	@Autowired
	private BoardQnaService qservice;
	
	
	//등록폼
	@GetMapping("qinsert/{productid}")
	@PreAuthorize("isAuthenticated()")
	public String insert(@PathVariable Long productid, Model model) {
		model.addAttribute("productid", productid);
		return "/qna/insert";
	}
	
	@PostMapping("qinsert/{productid}")
	public ResponseEntity<String> insert(@PathVariable Long productid, 
			 @RequestBody BoardQna boardqna,
			@AuthenticationPrincipal PrincipalUser principaluser) {
		  System.out.println(productid);
		Product p = new Product();
		p.setProductid(productid);
		boardqna.setProduct(p);
		boardqna.setMember(principaluser.getMember());
		qservice.insert(boardqna);
		return new ResponseEntity<String>("success",HttpStatus.OK);
	}

	
	
	//qna전체보기
//		@GetMapping("qlist")
//		public String qlist(Model model,
//				@PageableDefault(size = 5, sort = "qnanum", direction = Direction.DESC)Pageable pageable) {
//			Page<BoardQna> lists = qservice.findAll(pageable);
//			model.addAttribute("qlist",lists);
//			return "qna/list";
//			}
		
	
		
	// 특정삼품 qna
		@GetMapping("qlist/{productid}")
		public String list(@PathVariable Long productid, Model model,
				@PageableDefault(size = 5, sort = "qnanum", direction = Direction.DESC)Pageable pageable,
				@RequestParam(required = false, defaultValue = "") String field,
				@RequestParam(required = false, defaultValue = "") String word) {
			Page<BoardQna> lists =  qservice.findAll(field,word,pageable,productid);
			model.addAttribute("qlist", lists);
			model.addAttribute("productid", productid);
			return "qna/list";
		}
		
		
		//전체qna
				@GetMapping("qlist")
				public String qlist(Model model,
						@PageableDefault(size = 5, sort = "qnanum", direction = Direction.DESC)Pageable pageable,
						@RequestParam(required = false, defaultValue = "") String field,
						@RequestParam(required = false, defaultValue = "") String word) {
					Page<BoardQna> lists =  qservice.findAll(field,word,pageable);
					model.addAttribute("qalllist", lists);
					return "qna/alllist";
				}
		

		@GetMapping("qview/{qnanum}")
		public String detail(@PathVariable Long qnanum, Model model) {
			model.addAttribute("qlist", qservice.view(qnanum));
			return "qna/view";
		}
		
		
		
		
		//수정폼
		@GetMapping("qnaupdate/{qnanum}")
		public String update(@PathVariable Long qnanum,Model model) {
			model.addAttribute("qlist",qservice.view(qnanum));				
			return "qna/update";		
		}
		
		
		//수정
		@PutMapping("qnaupdate")
		@ResponseBody
		public String update(@RequestBody BoardQna board) {
			qservice.update(board);
			return "success";
		}
		

		//삭제
		@DeleteMapping("qnadelete/{qnanum}")
		@ResponseBody
		public Long delete(@PathVariable Long qnanum) {
			qservice.delete(qnanum);
			return qnanum;
		}
		
		
		
		
		


}
