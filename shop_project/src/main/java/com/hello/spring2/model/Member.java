package com.hello.spring2.model;



import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Member implements Serializable{

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long id;
	public String username;
	public String name;
	public String password;
	public String email;
	public String phone;
	public String roadaddr;
	public String jibunaddr;
	public String extraaddr;
	public String zipcode;
	public String role = "ROLE_MEMBER";
	public Member() {
		
	}

	public Member update(String name, String email) {
		this.name = name;
		this.email = email;
		return this;
	}
	
	@Builder
	public Member(String name, String email) {
		this.name = name;
		this.email = email;
	}
	
	
	
}
