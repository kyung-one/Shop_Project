package com.hello.spring2.model;


import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="t_order") //order는 jdbc 예약어라서 테이블 생성안됨
@DynamicUpdate
public class Order {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long ordernum;
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	public Date orderdate;
	public Long price;
	public String paywith;
	public String status="결제완료"; //주문상태 (결제완료,배송중 ,..)
	public String memo; //배송시 요청사항
	public Long memberid;
	public String trackingnum=" ";
	public String pname;
	
	public String ordname; //수령인정보
	public String ordemail; //수령인정보
	public String ordroadaddr;
	public String ordjibunaddr;	
	public String ordextraaddr;
	public String ordzipcode;
	public String ordphone;

}
