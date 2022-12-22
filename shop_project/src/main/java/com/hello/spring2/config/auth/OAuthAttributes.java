package com.hello.spring2.config.auth;

import java.util.Map;

import com.hello.spring2.model.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
public class OAuthAttributes {
	private Map<String, Object> attributes;
	private String nameAttributeKey;
	private String name;
	private String email;
	private String username;
	
	@Builder
	public OAuthAttributes(Map<String, Object> attributes,
				String nameAttributeKey, String name,
				String email,			 String username) {
		this.attributes = attributes;
		this.nameAttributeKey = nameAttributeKey;
		this.name = name;
		this.email = email;
		this.username = username;
	}
	/* of()
	 * OAuth2User에서 반환하는 사용자 정보는 Map이기 때문에 값 하나하나 변환
	 */
	
	
	
	public static OAuthAttributes of(String registrationId, String userNameAttributeName, Map<String, Object> attributes) {
		
		   // 여기서 네이버와 카카오 등 구분 (ofNaver, ofKakao)
        switch (registrationId) {
            case "google":
                return ofGoogle(userNameAttributeName, attributes);
            case "naver":
                return ofNaver(userNameAttributeName, attributes);
            case "kakao":
                return ofKakao(userNameAttributeName, attributes);
        }

        // TODO: Exception 발생
        return null;
		

	}
	
	 private static OAuthAttributes ofGoogle(String userNameAttributeName, Map<String, Object> attributes) {
			return OAuthAttributes.builder()
			.name((String) attributes.get("name"))
			.email((String) attributes.get("email"))
			.username((String) attributes.get("email"))
			.attributes(attributes)
			.nameAttributeKey(userNameAttributeName)
			.build();
	    }

	    private static OAuthAttributes ofNaver(String userNameAttributeName, Map<String, Object> attributes) {
	        // naver는 response에 유저정보가 있다.
	        Map<String, Object> response = (Map<String, Object>)attributes.get("response");

	        return OAuthAttributes.builder()
	                .name((String) response.get("name"))
	                .email((String) response.get("email"))
	                .attributes(attributes)
	                .nameAttributeKey(userNameAttributeName)
	                .build();
	    }

	    private static OAuthAttributes ofKakao(String userNameAttributeName, Map<String, Object> attributes) {
	        // kakao는 kakao_account에 유저정보가 있다. (email)
	        Map<String, Object> kakaoAccount = (Map<String, Object>)attributes.get("kakao_account");
	        // kakao_account안에 또 profile이라는 JSON객체가 있다. (nickname, profile_image)
	        Map<String, Object> kakaoProfile = (Map<String, Object>)kakaoAccount.get("profile");

	        return OAuthAttributes.builder()
	                .name((String) kakaoProfile.get("nickname"))
	                .email((String) kakaoAccount.get("email"))
	                .attributes(attributes)
	                .nameAttributeKey(userNameAttributeName)
	                .build();
	    }
	
	
	/* toEntity()
	 * User 엔티티 생성
	 * OAuthAttributes에서 엔티티 생성 시점 = 처음 가입 시
	 * OAuthAttributes 클래스 생성이 끝났으면 같은 패키지에 SessionUser 클래스 생성
	 */
	public Member toEntity() {
		return Member.builder()
			.name(name)
			.email(email)
			.build();
	}
}