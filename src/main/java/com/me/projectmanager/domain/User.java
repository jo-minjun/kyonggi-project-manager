package com.me.projectmanager.domain;

import com.me.projectmanager.domain.command.CreateUserCommand;
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
    this.profile = "/resources/image/profile.svg";
  }

  public static User createFrom(CreateUserCommand command) {
    return new User(command.getUsername(), command.getPassword(), command.getName());
  }

  public void setName(String name) {
    this.name = name;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public void setProfile(String savedPath) {
    this.profile = savedPath;
  }
}
