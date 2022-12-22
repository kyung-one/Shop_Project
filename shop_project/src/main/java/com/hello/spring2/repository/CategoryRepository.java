package com.hello.spring2.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hello.spring2.model.Category;

public interface CategoryRepository extends JpaRepository<Category, Long>{
	
	//검색
		public List<Category> findBycatnumContaining(String catnum);
		public List<Category> findBycatnameContaining(String catname);
		
		//검색 갯수
		@Query(value="select count(*) from category where catnum like CONCAT('%',:catword,'%')",
				nativeQuery = true)
		public Long cntcatnumSearch(@Param("catword") String catword);
		@Query(value="select count(*) from category where catname like CONCAT('%',:catword,'%')",
				nativeQuery = true)
		public Long cntcatnameSearch(@Param("catword") String catword);

}
