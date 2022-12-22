package com.hello.spring2.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.hello.spring2.config.auth.CustomOAuth2UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	@Bean
	public BCryptPasswordEncoder encodePwd() {
		return new BCryptPasswordEncoder();
	}
	
	  /* OAuth */
	 @Autowired 
	private CustomOAuth2UserService customOAuth2UserService;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		http.authorizeRequests()
		.antMatchers("/user/*").authenticated()
		.antMatchers("/mypage/*").authenticated()
		.antMatchers("/admin").hasRole("ADMIN")
		.antMatchers("/admin/*").hasRole("ADMIN")
		.antMatchers("/catlist").hasRole("ADMIN")
		.antMatchers("/shop/cart/").hasRole("ADMIN")

		.antMatchers("/noticeinsert").hasRole("ADMIN")
		.antMatchers("/shop/cart/*").authenticated()
		.antMatchers("/shop/checkout/*").authenticated()
		.antMatchers("/qinsert/*").authenticated()

		.anyRequest()
		.permitAll()
		.and()
		.formLogin()
		.loginPage("/login")
		.defaultSuccessUrl("/")
		.and()
		.logout()
		.logoutUrl("/logout")
		.logoutSuccessUrl("/")
		.invalidateHttpSession(true)
		 .and()					//추가
		  .oauth2Login()
		  .loginPage("/login")
		  .defaultSuccessUrl("/")
			.userInfoEndpoint()
				.userService(customOAuth2UserService);
	}
	
}