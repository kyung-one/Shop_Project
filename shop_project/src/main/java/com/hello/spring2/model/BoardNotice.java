package com.hello.spring2.model;


import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class BoardNotice {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long noticenum;
	public String title;
	public String content;
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	public Date regdate;
	
	@ManyToOne
	@JoinColumn(name="member_id")
	private Member member;
}
