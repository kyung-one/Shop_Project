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
import com.hello.spring2.model.Category;
import com.hello.spring2.model.Product;
import com.hello.spring2.service.categoryService;

@Controller
public class CategoryController {
	
	@Autowired
	private categoryService categoryservice;
	
	@GetMapping("/catinsert")
	//@PreAuthorize("isAuthenticated()")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String insert() {
		return "/product/category";		
	}
	
	

	@PostMapping("/catinsert")
	public String insert(Category category) {
		categoryservice.insert(category);
		
		return "redirect:catlist";
	}
	
	// 전체보기 
		@GetMapping("catlist")
		public String list(Model model,
				@RequestParam(required = false,defaultValue = "")String catfield,
				@RequestParam(required = false,defaultValue = "")String catword) {
			
			Long count = categoryservice.count(catfield,catword);
			
			List<Category> lists = categoryservice.list(catfield,catword);
			model.addAttribute("catcount", count);
			model.addAttribute("catlist", lists);
			return "/product/catlist";
		}
		


		@GetMapping("catview/{catnum}")
		public String detail(@PathVariable Long catnum, Model model) {
			model.addAttribute("catlist", categoryservice.view(catnum));
			return "/product/catview";
		}
		
		
		
		//수정폼
				@GetMapping("catupdate/{catnum}")
				public String update(@PathVariable Long catnum,Model model) {
					model.addAttribute("catlist",categoryservice.view(catnum));				
					return "/product/catupdate";		
				}
				
				
				//수정
				@PutMapping("/product/catupdate")
				@ResponseBody
				public String update(@RequestBody Category category) {
					categoryservice.update(category);
					return "success";
				}
				

				//삭제
				@DeleteMapping("catdelete/{catnum}")
				@ResponseBody
				public Long delete(@PathVariable Long catnum) {
					categoryservice.delete(catnum);
					return catnum;
				}
			
	
	

}
