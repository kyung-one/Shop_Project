package com.hello.spring2.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hello.spring2.model.BoardQna;
import com.hello.spring2.model.Comment;
import com.hello.spring2.repository.BoardQnaRepository;
import com.hello.spring2.repository.CommentRepository;

@Service
public class CommentService {

	@Autowired
	public CommentRepository commentrepository;
	
	@Autowired
	public BoardQnaRepository brepository;
	
	@Transactional
	public void insert(Comment comment) {
		//commentrepository.save(comment);
		
		//replyCny+1
		//BoardQna b = brepository.findById(comment.getQna().getQnanum()).get();
		//b.setReplyCnt(b.getReplyCnt()+1);
		//sql
		commentrepository.insert(comment.getContent(),
				comment.getQna().getQnanum(),
				comment.getMember().getId());
	}
	
	public List<Comment> list(Long qnanum){
		return commentrepository.findByqnanum(qnanum);
		
	}
	
	//삭제
		@Transactional
		public void delete(Long cnum) {
			
//			Comment comment = commentrepository.findById(cnum).get();
//			Board b = brepository.findById(comment.getBoard().getNum()).get();
//			b.setReplyCnt(b.getReplyCnt()-1);
			
		//	Optional<Comment>  c =  commentrepository.findById(cnum);
		//	Board b = c.get().getBoard();
		//	b.setReplyCnt(b.getReplyCnt()-1);
			
			
			commentrepository.deleteById(cnum);
		}
	
	
}
