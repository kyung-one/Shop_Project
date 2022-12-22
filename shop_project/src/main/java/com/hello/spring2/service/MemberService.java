package com.hello.spring2.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hello.spring2.model.Member;
import com.hello.spring2.repository.MemberRepository;

@Service
public class MemberService {
	@Autowired
	private BCryptPasswordEncoder encoder;
	@Autowired
	private MemberRepository mRepository;
	
	public void register(Member member) {
		//비번암호화해서저장
		String rawPassword=member.getPassword();
		String encPassword=encoder.encode(rawPassword);
		member.setPassword(encPassword); //암호화된 비번
		member.setRole("ROLE_USER");
		mRepository.save(member);
	}
	//수정폼 회원정보보기
	public Member mview(Long id) {
		Member member = mRepository.findById(id).get();
		return member;
	}
	//관리자 회원전체보기
	public List<Member> findAll() {
		List<Member> member= mRepository.findAll();
		return member;
	}
	//관리자 회원수정
	@Transactional
	public void changerole(Member member) {
		Member m = mRepository.findById(member.getId()).get();
		m.setRole(member.getRole());

	}
	
	//정보수정
	@Transactional
	public void modify(Member member) {
		Member m = mRepository.findById(member.getId()).get();
		String rawPassword=member.getPassword();
		String encPassword=encoder.encode(rawPassword);
		m.setEmail(member.getEmail());
		m.setPassword(encPassword);
		m.setExtraaddr(member.getExtraaddr());
		m.setJibunaddr(member.getJibunaddr());
		m.setRoadaddr(member.getRoadaddr());
		m.setPhone(member.getPhone());
		m.setZipcode(member.getZipcode());
	}
	//탈퇴
	public void deleteAcc(Long id) {
		mRepository.deleteById(id);
	}

}
