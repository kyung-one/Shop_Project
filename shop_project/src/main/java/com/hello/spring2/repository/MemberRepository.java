package com.hello.spring2.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.hello.spring2.model.Member;

public interface MemberRepository extends JpaRepository<Member, Long>{
	Member findByUsername(String username); 
	
	/* OAuth */
	Optional<Member> findByEmail(String email);
	

	//아이디 비밀번호찾기
			@Query(value="select * from member where username = :username and email = :email",
					nativeQuery = true)
			public Member memberIdSearch(String username , String email);
			
			
			@Query(value="select count(*) from member where username = :username and email = :email",
					nativeQuery = true)
			public int memberPwdCheck(String username , String email);
			
			@Modifying
			@Transactional
			@Query(value="update member set password = :enpassword where username = :username and email = :email and id = :id",
					nativeQuery = true)
			public void passwordUpdate(String enpassword ,String username , String email, Long id);

	
}
