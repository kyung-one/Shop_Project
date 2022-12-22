package com.hello.spring2.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hello.spring2.model.BoardQna;
import com.hello.spring2.model.Member;
import com.hello.spring2.model.Product;
import com.hello.spring2.repository.BoardQnaRepository;
import com.hello.spring2.repository.MemberRepository;
import com.hello.spring2.repository.ProductRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardQnaService {
	@Autowired
	private BoardQnaRepository qRepository;
	
	
	
	@Transactional
	//추가
	public void insert(BoardQna boardqna) {
		
		qRepository.insert(boardqna.getTitle(),
				boardqna.getContent(),
				boardqna.getMember().getId(),
				boardqna.getProduct().getProductid());
		

	}
	
	//페이징 검색 전체보기
	public Page<BoardQna> findAll(String field, String word, Pageable pageable,Long product_id){
		Page<BoardQna> lists= qRepository.findAllproduct_id(product_id, pageable);
		if(field.equals("title")) {
			lists = qRepository.findByTitleContaining(word,pageable);
		}else if (field.equals("content")) {
			lists = qRepository.findByContentContaining(word,pageable);
		}
		return lists;
	}
	
	//qna 전체보기
	public Page<BoardQna> findAll(String field, String word,Pageable pageable){
		Page<BoardQna> lists = qRepository.findAllByOrderByQnanumDesc(pageable);
		if(field.equals("title")) {
			lists = qRepository.findByTitleContaining(word,pageable);
		}else if (field.equals("content")) {
			lists = qRepository.findByContentContaining(word,pageable);
		}
		return lists;
	}
	
	
	
	//갯수
	public long count() {
		return qRepository.count();
	}
	
	//갯수
	public long count(String field,String word) {
		Long count = qRepository.count();
		if(field.equals("title")) {
			count = qRepository.cntTitleSearch(word);
		}else if (field.equals("content")) {
			count = qRepository.cntContentSearch(word);
		}
		
		return count;
	}

	
	//상세보기
	@Transactional
	public BoardQna view(Long qnanum) {
		BoardQna boardqna = qRepository.findById(qnanum).get();
		 return boardqna;
	}
	
	
	
	

	//수정(더티체킹)
	@Transactional
	public void update(BoardQna boardqna) {
		
		BoardQna qna = qRepository.findById(boardqna.getQnanum()).get();
		qna.setTitle(boardqna.getTitle());
		qna.setRegdate(new Date());
		qna.setContent(boardqna.getContent());
	
	}
	
	//삭제
	@Transactional
	public void delete(Long qnanum) {
		qRepository.deleteById(qnanum);
		//brepository.deleteByNum(num);
	}
	
	
	
	


}
