package com.hello.spring2.google;

import java.io.Serializable;

import com.hello.spring2.model.Member;

import lombok.Getter;

@Getter
public class SessionUser implements Serializable{
	private String name;
	private String email;
	private String username;
	
	public SessionUser(Member member) {
		this.name = member.getName();
		this.email = member.getEmail();
		this.username= member.getUsername();
	}
}