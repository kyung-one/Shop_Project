package com.hello.spring2.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
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

import com.hello.spring2.model.Member;
import com.hello.spring2.model.Order;
import com.hello.spring2.model.Product;
import com.hello.spring2.repository.MemberRepository;
import com.hello.spring2.service.CartService;
import com.hello.spring2.service.MemberService;
import com.hello.spring2.service.OrderService;
import com.hello.spring2.service.ProductService;

@Controller
public class HomeController {
	@Autowired
	private MemberService mService;
	@Autowired
	private MemberRepository mRepository;
	@Autowired
	private OrderService orderService;
	@Autowired
	private ProductService pService;
	@Autowired
	private CartService cService;
	
	//홈화면 상품
	@GetMapping("/")
	public String home(Model model,
			@RequestParam(required = false,defaultValue = "")String field,
			@RequestParam(required = false,defaultValue = "")String word) {
		List<Product>plist = pService.findAll(field,word);
		List<Product>rlist = pService.findAllDescReview();
		
		model.addAttribute("product",plist);
		model.addAttribute("product_r",rlist);
		return "home";
	}
	//홈화면 상세보기
	@GetMapping("pdetail/{productid}")
	public String view(@PathVariable Long productid, Model model) {
		Product plist = pService.view(productid);
		model.addAttribute("product",plist);
		return "/product/pdetail";
	}
	//로그인
	@GetMapping("/login")
	public String login() {
		return "/user/login";
	}

	// 회원가입폼
	@GetMapping("register")
	public String register() {
		return "/user/join";
	}

	// 회원가입
	@PostMapping("register")
	@ResponseBody
	public String register(@RequestBody Member member) {
		// username 중복시 fail
		if (mRepository.findByUsername(member.getUsername()) != null) {
			return "fail";
		}
		mService.register(member);
		return "success";
	}
	//관리자 회원관리
	@GetMapping("/admin/members")
	public String members(Model model) {
		List<Member>members = mService.findAll();
		model.addAttribute("members",members);
		return "/admin/members";

	}
	//관리자 회원상세
	@GetMapping("/admin/memberdetail/{id}")
	public String mdetail(@PathVariable Long id, Model model) {
		Member member = mService.mview(id);
		model.addAttribute("members",member);
		return "/admin/memberdetail";
	}
	//관리자 회원수정
	@PutMapping("/admin/memberUpdate")
	@ResponseBody
	public String memberUpdate(@RequestBody Member member) {
		mService.changerole(member);
		return "success";
	}
	
	//마이페이지
	@GetMapping("mypage/{id}")
	@PreAuthorize("isAuthenticated()")
	public String mypage(@PathVariable Long id, Model model) {
		List<Order>orders=orderService.ordlist(id);
		model.addAttribute("orders",orders);
		return "/user/mypage";
	}
	//관리자페이지
	@GetMapping("admin")
	@PreAuthorize("isAuthenticated()")
	public String admin(Model model) {
		List<Order>orders=orderService.ordlist();
		model.addAttribute("orders",orders);
		return "/admin/admin";
	}
	//관리자 주문상세보기
	@GetMapping("admin_orddetail/{ordernum}")
	public String orderView(@PathVariable Long ordernum, Model model) {
		Order orders = orderService.orderView(ordernum);
		model.addAttribute("orders",orders);
		return "/admin/admin_orddetail";
	}
	//회원 주문상세보기
	@GetMapping("/shop/orddetail/{ordernum}")
	public String m_orderView(@PathVariable Long ordernum, Model model) {
		Order orders = orderService.orderView(ordernum);
		model.addAttribute("orders",orders);
		return "/shop/orddetail";
	}
	//관리자 주문변경
	@PutMapping("admin_ordUpdate")
	@ResponseBody
	public String ordUpdate(@RequestBody Order order) {
		orderService.ordUpdate(order);
		return "success";
	}
	//관리자 주문취소
	@DeleteMapping("cancelOrd/{ordernum}")
	@ResponseBody
	public String cancelOrd(@PathVariable Long ordernum) {
		orderService.cancelOrd(ordernum);
		return "success";
	}

	//정보수정폼
	@GetMapping("mypage/modify/{id}")
	@PreAuthorize("isAuthenticated()")
	public String modify(@PathVariable Long id, Model model) {
		Member member = mService.mview(id);
		model.addAttribute("member",member);
		return "/user/modify";
	}
	//정보수정
	@PutMapping("modify")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public String modify(@RequestBody Member member) {
		mService.modify(member);
		return "success";
	}
	//탈퇴
	@DeleteMapping("deleteAcc/{id}")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public String deleteAcc(@PathVariable Long id,HttpSession session) {
		mService.deleteAcc(id);
		session.invalidate();
		return "success";
	}

	
}
