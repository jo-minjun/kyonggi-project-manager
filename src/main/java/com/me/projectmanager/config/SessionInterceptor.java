package com.me.projectmanager.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class SessionInterceptor implements HandlerInterceptor {

  private static final String USER_SESSION_KEY = "loggedInUser";

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    Object loggedInUser = request.getSession().getAttribute(USER_SESSION_KEY);

    if (loggedInUser == null) {
      response.sendRedirect("/login");
      return false;
    }

    return true;
  }
}
