package com.hello.spring2.service;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hello.spring2.model.BoardNotice;
import com.hello.spring2.model.Member;
import com.hello.spring2.repository.BoardNoticeRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardNoticeService {
	
	private final BoardNoticeRepository boardNoticeRepository;
	
	//추가
	@Transactional
	public void insert(BoardNotice boardnotice, Member member) {
		
		boardnotice.setMember(member);
		boardNoticeRepository.save(boardnotice);
	}
	
	
	//전체보기(페이징x)
	public List<BoardNotice> list(){
		return boardNoticeRepository.findAll();
	}
	
	// 검색 전체보기
	public List<BoardNotice> findAll(String field, String word){
		List<BoardNotice> lists= boardNoticeRepository.findAll();
		if(field.equals("title")) {
			lists = boardNoticeRepository.findByTitleContaining(word);
		}else if (field.equals("content")) {
			lists = boardNoticeRepository.findByContentContaining(word);
		}
		
		
		return lists;
		
	}
	
	//갯수
	public long count(String field,String word) {
		Long count = boardNoticeRepository.count();
		if(field.equals("title")) {
			count = boardNoticeRepository.cntTitleSearch(word);
		}else if (field.equals("content")) {
			count = boardNoticeRepository.cntContentSearch(word);
		}
		
		return count;
	}
	
	
	//갯수
	public long count() {
		return boardNoticeRepository.count();
	}
	
	
	//상세보기
	@Transactional
	public BoardNotice view(Long noticenum) {
		BoardNotice board = boardNoticeRepository.findById(noticenum).get();
		 return board;
	}
	
	
	

	//수정(더티체킹)
	@Transactional
	public void update(BoardNotice board) {
		
		BoardNotice m = boardNoticeRepository.findById(board.getNoticenum()).get();
		m.setTitle(board.getTitle());
		m.setRegdate(new Date());
		m.setContent(board.getContent());
	
	}
	
	//삭제
	@Transactional
	public void delete(Long noticenum) {
		boardNoticeRepository.deleteById(noticenum);
		//brepository.deleteByNum(num);
	}
	
	

}
