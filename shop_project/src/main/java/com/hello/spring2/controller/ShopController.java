package com.hello.spring2.controller;

import java.util.List;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hello.spring2.model.Cart;
import com.hello.spring2.model.Member;
import com.hello.spring2.model.Order;
import com.hello.spring2.model.Product;
import com.hello.spring2.service.CartService;
import com.hello.spring2.service.OrderService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/shop/*")
@RequiredArgsConstructor
public class ShopController {
	private final CartService cartService;
	private final OrderService orderService;
	
	//장바구니추가
	@PostMapping("addCart")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	private String addCart(Cart cart,Long productid) {

		Product p = new Product();
		p.setProductid(productid);
		cart.setProduct(p);
		cartService.addCart(cart);
		return "success";
	}
	//장바구니보기
	@GetMapping("cart/{username}")
	@PreAuthorize("isAuthenticated()")

	public String cartView(@PathVariable String username, Model model) {
		List<Cart>cart=cartService.viewCart(username);
		model.addAttribute("cart",cart);
		return "/shop/cart";
	}


	//장바구니삭제
	@DeleteMapping("delCart/{cartnum}")
	@ResponseBody
	public String cartDel(@PathVariable Long cartnum) {
		cartService.del(cartnum);
		return "success";
	}
	//장바구니전체삭제
	@DeleteMapping("delAll/{username}")
	@ResponseBody
	public String delAll(@PathVariable String username) {
		System.out.println(username);
		cartService.delAll(username);
		return "success";
	}
	//결제폼
	@GetMapping("checkout/{username}")
	public String checkout(@PathVariable String username,Model model) {
		List<Cart>cart=cartService.viewCart(username);
		model.addAttribute("cart",cart);
		
		Long cartcount= cartService.countCart(username);
		model.addAttribute("countCart",cartcount);
		String random = RandomStringUtils.randomAlphanumeric(10);
		model.addAttribute("random",random);
		
		return "/shop/checkout";
	}
	
	//결제
	@PostMapping("checkout")
	@ResponseBody
	public String checkout(@RequestBody Order order, Long id,String username) {
	orderService.checkout(order);
	return "success";
	}

	//결제완료시 카트삭제
	@DeleteMapping("checkout/{username}")
	@ResponseBody
	public String delcheckout(@PathVariable String username) {
	cartService.delAll(username);
	return "username";
	}

}