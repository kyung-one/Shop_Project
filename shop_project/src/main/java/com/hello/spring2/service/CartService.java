package com.hello.spring2.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.stereotype.Service;

import com.hello.spring2.model.Cart;
import com.hello.spring2.model.Product;
import com.hello.spring2.repository.CartRepository;

import lombok.RequiredArgsConstructor;


@Service
@Transactional
@RequiredArgsConstructor
public class CartService {
	
	private final CartRepository cartRepository;
		
	//장바구니보기
	public List<Cart> viewCart(String username) {
		List<Cart> list = cartRepository.findByUsername(username);
		return list;
	}

	public long count(String username) {
		Long count = cartRepository.count(username);
		return count;
	}
	
	//갯수
	public Long countCart(String username) {
	Long listcount = cartRepository.count(username);
	return listcount;
			}
	
	//장바구니추가
	public void addCart(Cart cart) {
		cartRepository.save(cart);
	}

	//장바구니삭제
	public void del(Long cartnum) {
		cartRepository.deleteById(cartnum);
	}
	//장바구니삭제 username
	public void delAll(String username) {
		cartRepository.deleteByUsername(username);
	}
}
