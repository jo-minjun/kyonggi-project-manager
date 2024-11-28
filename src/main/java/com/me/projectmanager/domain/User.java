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

  public User(String username, String password, String name) {
    this.username = username;
    this.password = password;
    this.name = name;
  }

  public static User createFrom(CreateUserCommand command) {
    return new User(command.getUsername(), command.getPassword(), command.getName());
  }
}
