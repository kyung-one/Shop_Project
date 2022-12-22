package com.hello.spring2.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hello.spring2.config.auth.PrincipalUser;
import com.hello.spring2.model.BoardNotice;
import com.hello.spring2.model.Product;
import com.hello.spring2.service.BoardNoticeService;

@Controller
public class NoticeController {
	
	
	@Autowired
	private BoardNoticeService boardnoticeservice;
	
	
	@GetMapping("/noticeinsert")
	//@PreAuthorize("isAuthenticated()")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String insert() {
		return "/notice/insert";
	}
	
	@PostMapping("/noticeinsert")
	public String insert(BoardNotice boardnotice, @AuthenticationPrincipal PrincipalUser principal) {
		boardnoticeservice.insert(boardnotice,principal.getMember());
		
		return "redirect:noticelist";
	}
	
	
	// 전체보기 
	@GetMapping("noticelist")
	public String list(Model model,
			@RequestParam(required = false,defaultValue = "")String field,
			@RequestParam(required = false,defaultValue = "")String word) {
		Long count = boardnoticeservice.count(field,word);
		List<BoardNotice> lists = boardnoticeservice.findAll(field,word);
		model.addAttribute("count", count);
		model.addAttribute("list", lists);
		return "/notice/list";
	}
	


	
	

	@GetMapping("view/{noticenum}")
	public String detail(@PathVariable Long noticenum, Model model) {
		model.addAttribute("list", boardnoticeservice.view(noticenum));
		return "/notice/view";
	}
	
	
	//수정폼
		@GetMapping("update/{noticenum}")
		public String update(@PathVariable Long noticenum,Model model) {
			model.addAttribute("list",boardnoticeservice.view(noticenum));				
			return "/notice/update";		
		}
		
		
		//수정
		@PutMapping("/notice/update")
		@ResponseBody
		public String update(@RequestBody BoardNotice board) {
			boardnoticeservice.update(board);
			return "success";
		}
		

		//삭제
		@DeleteMapping("delete/{noticenum}")
		@ResponseBody
		public Long delete(@PathVariable Long noticenum) {
			boardnoticeservice.delete(noticenum);
			return noticenum;
		}
	

}
