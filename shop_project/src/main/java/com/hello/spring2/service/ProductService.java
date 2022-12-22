package com.hello.spring2.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hello.spring2.model.Product;
import com.hello.spring2.repository.ProductRepository;

@Service
public class ProductService {
	@Autowired
	private ProductRepository pRepository;

	
	//제품등록
	public void pinsert(Product product) {
		Product p = new Product();
		p.setFilename(product.getFilename());
		p.setFileOriName(product.getFileOriName());
		p.setFileurl(product.getFileurl());
		
		p.setCategory(product.getCategory()); 
		pRepository.save(product);
	}
	//목록 검색  페이지x
	public List<Product>findAll(String field, String word){
		List<Product> lists = pRepository.findAllByOrderByProductidDesc();
		if (field.equals("pname")) {
			lists = pRepository.findByPnameContaining(word);
		} else if (field.equals("manufacturer")) {
			lists = pRepository.findByManufacturerContaining(word);
		}
		return lists;
	}
	//리뷰갯수정렬
	public List<Product>findAllDescReview(){
		List<Product> rlists = pRepository.findAllByOrderByReviewcntDesc();
		return rlists;
	}
	//갯수
	public long count(String field, String word) {
		Long count = pRepository.count();
		if (field.equals("pname")) {
			count = pRepository.cntPnameSearch(word);
		} else if (field.equals("manufacturer")) {
			count = pRepository.cntManufacturerSearch(word);
		}
		return count;
	}
	//상세보기
	public Product view(Long productid) {
		Product product = pRepository.findById(productid).get();
		return product;
	}

}
