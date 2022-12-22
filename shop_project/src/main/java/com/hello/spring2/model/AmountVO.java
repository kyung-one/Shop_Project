package com.hello.spring2.model;

import lombok.Data;

@Data
public class AmountVO {

	//카카오페이
	
	 private Integer total, tax_free, vat, point, discount;
}
