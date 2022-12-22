package com.hello.spring2.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hello.spring2.config.auth.PrincipalUser;
import com.hello.spring2.model.BoardQna;
import com.hello.spring2.model.Comment;
import com.hello.spring2.service.CommentService;




@Controller
@RestController
@RequestMapping("/qnareply/*")
public class QnaCommentController {
	
	
	@Autowired
	public CommentService commentService;
	
	//댓글추가
	@PostMapping("qinsert/{qnanum}")
	public ResponseEntity commentInsert(@PathVariable Long qnanum, @RequestBody Comment comment,
			@AuthenticationPrincipal PrincipalUser principal) {
		
		
		
		BoardQna b = new BoardQna();
		b.setQnanum(qnanum);  //bnum을 의미
		comment.setQna(b);
		
		//PrincipalUser p =(PrincipalUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//comment.setUser(p.getUser());
		
		comment.setMember(principal.getMember());
		commentService.insert(comment);
		
		return new ResponseEntity<String>("success",HttpStatus.OK);
		
	}
	
	//전체보기
	@GetMapping("qlist/{qnanum}")
	public List<Comment> list(@PathVariable Long qnanum){
		System.out.println("qnanum:"+ qnanum);
		List<Comment> clist = commentService.list(qnanum);
		return  clist;
	}
	
	
	@DeleteMapping("qdelete/{cnum}")
	public Long delete(@PathVariable Long cnum) {
		commentService.delete(cnum);
		return cnum;
	}

}
