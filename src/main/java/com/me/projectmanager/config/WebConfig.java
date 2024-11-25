package com.me.projectmanager.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

  @Autowired
  private SessionInterceptor sessionInterceptor;

  @Override
  public void addInterceptors(InterceptorRegistry registry) {
    registry.addInterceptor(sessionInterceptor)
        .addPathPatterns("/**") // 모든 경로에 대해 적용
        .excludePathPatterns("/login", "/signup", "/logout", "/resources/**", "/css/**", "/js/**", "/images/**"); // 제외 경로 설정
  }
}

