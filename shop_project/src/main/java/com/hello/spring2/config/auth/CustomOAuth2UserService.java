package com.hello.spring2.config.auth;

import java.util.Collections;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.hello.spring2.google.SessionUser;
import com.hello.spring2.model.Member;
import com.hello.spring2.repository.MemberRepository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
	   private final MemberRepository memberRepository;
	    private final HttpSession httpSession;

	    @Override
	    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
	        OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
	        OAuth2User oAuth2User = delegate.loadUser(userRequest);

	        // OAuth2 서비스 id (구글, 카카오, 네이버)
	        String registrationId = userRequest.getClientRegistration().getRegistrationId();
	        // OAuth2 로그인 진행 시 키가 되는 필드 값(PK)
	        String userNameAttributeName = userRequest.getClientRegistration().getProviderDetails().getUserInfoEndpoint().getUserNameAttributeName();

	        // OAuth2UserService
	        OAuthAttributes attributes = OAuthAttributes.of(registrationId, userNameAttributeName, oAuth2User.getAttributes());
	        Member member = saveOrUpdate(attributes);
	        member.setUsername(attributes.getEmail());
	        httpSession.setAttribute("member", new SessionUser(member)); // SessionMember (직렬화된 dto 클래스 사용)

	        // TODO: JWT 생성
	     
//	        return new DefaultOAuth2User(Collections.singleton(new SimpleGrantedAuthority(member.getRole())),
//	                attributes.getAttributes(),
//	                attributes.getNameAttributeKey());
	        return new PrincipalUser(member, oAuth2User.getAttributes());
	    }

	    // 유저 생성 및 수정 서비스 로직
	    private Member saveOrUpdate(OAuthAttributes attributes){
	        Member member = memberRepository.findByEmail(attributes.getEmail())
	                .map(entity -> entity.update(attributes.getName(), attributes.getEmail()))
	                .orElse(attributes.toEntity());
	        member.setUsername(attributes.getEmail());

	        return memberRepository.save(member);
	    }
	}