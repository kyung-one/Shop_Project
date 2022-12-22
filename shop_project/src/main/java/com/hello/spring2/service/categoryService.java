package com.hello.spring2.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hello.spring2.model.BoardNotice;
import com.hello.spring2.model.Category;
import com.hello.spring2.model.Member;
import com.hello.spring2.model.Product;
import com.hello.spring2.repository.BoardNoticeRepository;
import com.hello.spring2.repository.CategoryRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class categoryService {
	
	private final CategoryRepository categoryrepository;
	
	//추가
		@Transactional
		public void insert(Category category) {
			
		
			categoryrepository.save(category);
		}
		
		
		

		//전체보기(페이징x)
		public List<Category> list(String catfield, String catword){
			List<Category> catlists = categoryrepository.findAll();
			
			if (catfield.equals("catname")) {
				catlists = categoryrepository.findBycatnameContaining(catword);
			}
			return catlists;
			
		}
		
		
		
		
		//갯수
		public long count() {
			return categoryrepository.count();
		}
		
		//갯수
		public long count(String catfield, String catword) {
			Long count = categoryrepository.count();
			 if (catfield.equals("catname")) {
				count = categoryrepository.cntcatnameSearch(catword);
			}
			return count;
		}
		
		
		//상세보기
		@Transactional
		public Category view(Long catnum) {
			Category category = categoryrepository.findById(catnum).get();
			 return category;
		}
		
		
		
		//수정(더티체킹)
		@Transactional
		public void update(Category category) {
			
			Category m = categoryrepository.findById(category.getCatnum()).get();
			m.setCatname(category.getCatname());
		}
		
		//삭제
		@Transactional
		public void delete(Long catnum) {
			categoryrepository.deleteById(catnum);
			//brepository.deleteByNum(num);
		}
		
		
		

}
