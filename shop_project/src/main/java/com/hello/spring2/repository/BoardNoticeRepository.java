package com.hello.spring2.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hello.spring2.model.BoardNotice;

public interface BoardNoticeRepository extends JpaRepository<BoardNotice, Long>{
	
public List<BoardNotice> findByTitleContaining(String title);
	
	public List<BoardNotice> findByContentContaining(String content);
	
	//제목 검색 개수
	@Query(value="select count(*) from board_notice where title like CONCAT('%',:word,'%')",
	nativeQuery = true)
	public Long cntTitleSearch(@Param("word") String word);
	@Query(value="select count(*) from board_notice where content like CONCAT('%',:word,'%')",
	nativeQuery = true)
	public Long cntContentSearch(@Param("word") String word);
}
