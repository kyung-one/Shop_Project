package com.hello.spring2.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.hello.spring2.model.Category;
import com.hello.spring2.model.Product;
import com.hello.spring2.service.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	@Autowired
	private ProductService pService;

	// 등록폼
	@GetMapping("pinsert")
	public String pinsert() {
		return "/product/pinsert";
	}

	// 제품등록
	@PostMapping("pinsert")
	public String pinsert(Product product,HttpServletRequest request, @RequestPart MultipartFile files,Long catnum) throws Exception {
		Category c = new Category();
		c.setCatnum(catnum);
		product.setCategory(c);
		
		String sourceFileName = files.getOriginalFilename();
		String sourceFileNameExtension = FilenameUtils.getExtension(sourceFileName).toLowerCase();
		File destinationFile;
		String destinationFileName;
		String fileUrl = "D:/springboot_workspace/shop_project/src/main/resources/static/image/";

		do {
			destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + sourceFileNameExtension;
			destinationFile = new File(fileUrl + destinationFileName);
		} while (destinationFile.exists());

		destinationFile.getParentFile().mkdirs();
		files.transferTo(destinationFile);

		product.setFilename(destinationFileName);
		product.setFileOriName(sourceFileName);
		product.setFileurl(fileUrl);

		pService.pinsert(product);
		return "redirect:/product/plist";
	}
	//상품목록
	@GetMapping("plist")
	public String plist(Model model,
			@RequestParam(required = false,defaultValue = "")String field,
			@RequestParam(required = false,defaultValue = "")String word) {
		Long count = pService.count(field,word);
		List<Product>plist = pService.findAll(field,word); //pageable
		model.addAttribute("product",plist);
		model.addAttribute("count",count);
		return "/product/plist";
	}
	//인기상품(리뷰순)
	@GetMapping("hotlist")
	public String hotlist(Model model,
			@RequestParam(required = false,defaultValue = "")String field,
			@RequestParam(required = false,defaultValue = "")String word) {
		Long count = pService.count(field,word);
		List<Product>hlist = pService.findAllDescReview();
		model.addAttribute("product",hlist);
		model.addAttribute("count",count);
		return "/product/hotlist";
	}
	//상세보기
	@GetMapping("pdetail/{productid}")
	public String view(@PathVariable Long productid, Model model) {
		Product plist = pService.view(productid);
		model.addAttribute("product",plist);
		return "/product/pdetail";
	}
}
