package com.hello.spring2.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hello.spring2.model.BoardReview;
import com.hello.spring2.model.Product;
import com.hello.spring2.repository.BoardReviewRepository;
import com.hello.spring2.repository.ProductRepository;



@Service
public class BoardReviewService {
	
	@Autowired
	public BoardReviewRepository boardReviewRepository;
	
	@Autowired
	public ProductRepository productRepository;
	
	
	@Transactional
	public void insert(BoardReview boardReview) {
		//boardReviewRepository.save(boardReview);
		
		
		 boardReviewRepository.insert(boardReview.getContent(),
				boardReview.getProduct().getProductid(),
				boardReview.getRating(),
				boardReview.getMember().getId());
			
		 //replyCny+1
			Product p = productRepository.findById(boardReview.getProduct().getProductid()).get();
			p.setReviewcnt(p.getReviewcnt()+1);
	}
	
	public List<BoardReview> list(Long product_id){
		return boardReviewRepository.findByproductid(product_id);
		
	}
	
	//삭제
		@Transactional
		public void delete(Long reviewnum) {
			
//			Comment comment = commentrepository.findById(cnum).get();
//			Board b = brepository.findById(comment.getBoard().getNum()).get();
//			b.setReplyCnt(b.getReplyCnt()-1);
			
			//Optional<BoardReview>  c =  boardReviewRepository.findById(reviewnum);
			//Product p = c.get().getBoard();
			//p.setReplyCnt(p.getReplyCnt()-1);
			
			
			boardReviewRepository.deleteById(reviewnum);
		}
	

}
