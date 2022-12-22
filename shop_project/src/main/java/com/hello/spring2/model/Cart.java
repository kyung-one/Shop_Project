package com.hello.spring2.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Cart {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long cartnum;
	public Long amount;
	public String username;
	public String p_name;
	public String p_price;
	public String p_img;

	@ManyToOne
	@JoinColumn(name="productid")
	private Product product;
	
}
