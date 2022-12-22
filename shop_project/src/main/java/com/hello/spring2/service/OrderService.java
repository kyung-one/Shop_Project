package com.hello.spring2.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hello.spring2.model.Member;
import com.hello.spring2.model.Order;
import com.hello.spring2.repository.OrderRepository;
import com.hello.spring2.repository.ProductRepository;

@Service
public class OrderService {
	@Autowired
	private OrderRepository oRepository;
	@Autowired
	private ProductRepository pRepository;
	

	// 결제db에저장
	public void checkout(Order order) {
		oRepository.save(order);
	}

	// 마이페이지 주문목록
	public List<Order> ordlist(Long id) {
		List<Order> orders = oRepository.findByMemberid(id);
		return orders;
	}

	// 관리자 주문목록
	public List<Order> ordlist() {
		List<Order> orders = oRepository.findAllByOrderByOrdernumDesc();
		return orders;
	}

	// 관리자 주문상세
	public Order orderView(Long ordernum) {
		Order orders = oRepository.findById(ordernum).get();
		return orders;
	}

	// 주문상태변경
	@Transactional
	public void ordUpdate(Order order) {
		Order o = oRepository.findById(order.getOrdernum()).get();

		o.setStatus(order.getStatus());
		o.setTrackingnum(order.getTrackingnum());
	}
	//주문취소
	public void cancelOrd(Long ordernum) {
		oRepository.deleteById(ordernum);
	}
	
}
