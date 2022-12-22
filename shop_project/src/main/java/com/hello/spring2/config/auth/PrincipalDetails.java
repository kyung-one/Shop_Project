package com.hello.spring2.config.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hello.spring2.model.Member;
import com.hello.spring2.repository.MemberRepository;

@Service
public class PrincipalDetails implements UserDetailsService {
	@Autowired
	private MemberRepository mRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("loadUserByUsername");
		Member member = mRepository.findByUsername(username);
		if(member==null) return null;
		//회원이라면 시큐리티 적용된 유저 리턴
		PrincipalUser puser = new PrincipalUser(member);
		System.out.println("puser : "+puser);
		return puser;
	}
}