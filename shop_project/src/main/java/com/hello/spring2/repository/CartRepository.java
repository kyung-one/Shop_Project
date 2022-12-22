package com.hello.spring2.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hello.spring2.model.Cart;

public interface CartRepository extends JpaRepository<Cart, Long> {
	
	public List<Cart> findByUsername(String username);
	public void deleteByUsername(String username);
	
	@Query(value="select count(*) from cart where username=:username", nativeQuery = true)
	public Long count(@Param("username") String username);
	
}
