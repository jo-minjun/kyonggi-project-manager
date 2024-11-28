package com.me.projectmanager.presentation.mapper;

import com.me.projectmanager.domain.command.CreateUserCommand;

public interface UserDtoMapper {

  static CreateUserCommand toCreateUserCommand(String username, String password, String confirmPassword, String name) {
    return new CreateUserCommand(username, password, name);
  }
}
