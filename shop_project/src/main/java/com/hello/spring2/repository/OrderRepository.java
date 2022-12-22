package com.hello.spring2.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hello.spring2.model.Order;

public interface OrderRepository extends JpaRepository<Order, Long>{
//	public List<Order> findByMemberid(Long id);
	public List<Order> findAllByOrderByOrdernumDesc();
	
	@Query(value="select * from t_order where memberid=:memberid order by ordernum desc", nativeQuery = true)
	public List<Order> findByMemberid(@Param("memberid") Long id);
}
