package com.me.projectmanager.presentation.mapper;

import com.me.projectmanager.domain.User;
import com.me.projectmanager.domain.command.CreateUserCommand;
import com.me.projectmanager.presentation.dto.UserDto;

public interface UserDtoMapper {

  static CreateUserCommand toCreateUserCommand(String username, String password, String confirmPassword, String name) {
    return new CreateUserCommand(username, password, name);
  }

  static UserDto toUserDto(User user) {
    return new UserDto(user.getId(), user.getUsername(), user.getName(), user.getProfile());
  }
}
