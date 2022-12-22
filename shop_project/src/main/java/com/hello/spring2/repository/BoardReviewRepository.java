package com.hello.spring2.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.hello.spring2.model.BoardReview;

public interface BoardReviewRepository extends JpaRepository<BoardReview, Long>{
	
	
	//댓글추가
	@Modifying
	@Query(value = "insert into board_review(content,regdate,product_id,rating,member_id) values(?1,now(),?2,?3,?4)",
	nativeQuery=true)
	public void insert(String boardreview,Long product_id , Long rating, Long member_id);
		
	
	
	 
	//@Query(value ="select sc from board_review sc join fetch sc.product where product_id=?1",nativeQuery=true) //LAZY(패치조인)
	@Query(value ="select * from board_review  where product_id=?1",
		nativeQuery=true) 
	public List<BoardReview> findByproductid(Long product_id);
	
	

}
