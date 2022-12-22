package com.hello.spring2.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Category {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long catnum;
	public String catname;
}
