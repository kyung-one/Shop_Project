package com.hello.spring2.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hello.spring2.model.BoardQna;

public interface BoardQnaRepository extends JpaRepository<BoardQna, Long>{

	
	
//	//product id추가
	@Modifying
	@Query(value="insert into board_qna(title,content,regdate,member_id,product_id) values(?1,?2,now(),?3,?4)",
	nativeQuery=true)
	public void insert(String title, String content, Long member_id,Long product_id);
	
	
	//댓글추가
	//	@Modifying
	//	@Query(value = "insert into board_review(content,regdate,product_id,rating,member_id) values(?1,now(),?2,?3,?4)",
	//	nativeQuery=true)
	//	public void insert(String boardreview,Long product_id , Long rating, Long member_id);
			
	@Query(value="select * from board_qna where product_id = :product_id ",
			nativeQuery = true)
	public Page<BoardQna> findAllproduct_id(Long product_id,Pageable pageable);
	
	//qna전체보기
	@Query(value="select * from board_qna order by qnanum desc", nativeQuery = true)
	public Page<BoardQna> findAllByOrderByQnanumDesc(Pageable pageable);
		
	
	public Page<BoardQna> findByTitleContaining(String title,Pageable pageable);
	
	public Page<BoardQna> findByContentContaining(String content,Pageable pageable);
	
	//제목 검색 개수
	@Query(value="select count(*) from board_qna where title like CONCAT('%',:word,'%')",
	nativeQuery = true)
	public Long cntTitleSearch(@Param("word") String word);
	@Query(value="select count(*) from board_qna where content like CONCAT('%',:word,'%')",
	nativeQuery = true)
	public Long cntContentSearch(@Param("word") String word);
	
	
}
