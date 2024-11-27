package com.me.projectmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class User {

  private Long id;

  private String username;

  private String password;

  private String name;

  private String profile;
}
