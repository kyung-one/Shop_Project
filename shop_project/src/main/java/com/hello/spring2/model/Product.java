package com.hello.spring2.model;

import javax.persistence.Column;
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
public class Product {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long productid;
	public String pname;
	public String price;
	public String manufacturer;
	public String pinfo;
	public Long pstock;
	public int reviewcnt=0;
	@ManyToOne
	@JoinColumn(name="catnum")
	private Category category;

	//이미지업로드
	String filename;
	@Column(name="fileoriname")
	String fileOriName;
	String fileurl;

}
