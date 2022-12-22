package com.hello.spring2.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.hello.spring2.model.BoardReview;
import com.hello.spring2.model.Comment;

public interface CommentRepository extends JpaRepository<Comment, Long>{
	
	
	//전체보기
	// JPQL (java Persistence Query Language:엔티티 객체를 중심) 
	//@Query("select sc from comment sc where qnanum=?1")  //Eager (Board.java)
	//@Query("select sc from comment sc join fetch sc.board_qna where qnanum=?1") //LAZY(패치조인)
	@Query(value ="select * from comment  where qnanum=?1",
			nativeQuery=true) 
	public List<Comment> findByqnanum(Long qnanum);
	
	
	//댓글추가
	@Modifying
	@Query(value = "insert into comment(content,regdate,qnanum,member_id) values(?1,now(),?2,?3)",
	nativeQuery=true)
	public void insert(String comment, Long qnanum, Long member_id);
	

}
