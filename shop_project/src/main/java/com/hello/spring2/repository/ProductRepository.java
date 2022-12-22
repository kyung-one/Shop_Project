package com.hello.spring2.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hello.spring2.model.Product;

public interface ProductRepository extends JpaRepository<Product, Long>{
	
	//제품id순
	public List<Product> findAllByOrderByProductidDesc();
	//리뷰순
	public List<Product> findAllByOrderByReviewcntDesc();

	
	//검색
	public List<Product> findByPnameContaining(String content);
	public List<Product> findByManufacturerContaining(String title);
	//검색 갯수
	@Query(value="select count(*) from product where pname like CONCAT('%',:word,'%')",
			nativeQuery = true)
	public Long cntPnameSearch(@Param("word") String word);
	@Query(value="select count(*) from product where manufacturer like CONCAT('%',:word,'%')",
			nativeQuery = true)
	public Long cntManufacturerSearch(@Param("word") String word);
	
}
