package com.hello.spring2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hello.spring2.model.Member;
import com.hello.spring2.repository.MemberRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class accountService {
	
	private final MemberRepository memberRepository;

	
	@Transactional
	public Member memberIdSearch(String username , String email) {
		return memberRepository.memberIdSearch(username,email);
	}
	
	
	@Transactional
	public int memberPwdCheck(String username , String email) {
		return memberRepository.memberPwdCheck(username,email);
	}
	
	@Transactional
	public void passwordUpdate(String enpassword, String username , String email,Long id) {
		
		memberRepository.passwordUpdate(enpassword,username,email,id);
	}
	
}
