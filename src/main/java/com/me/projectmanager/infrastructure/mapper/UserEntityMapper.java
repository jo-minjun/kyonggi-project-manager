package com.me.projectmanager.infrastructure.mapper;

import com.me.projectmanager.domain.User;
import com.me.projectmanager.infrastructure.entity.UserEntity;

public interface UserEntityMapper {

  static UserEntity toUserEntity(User user) {
    return new UserEntity(user.getId(), user.getUsername(), user.getPassword(), user.getName(), user.getProfile());
  }

  static User toUser(UserEntity userEntity) {
    return new User(userEntity.getId(), userEntity.getUsername(), userEntity.getPassword(), userEntity.getName(), userEntity.getProfile());
  }
}
