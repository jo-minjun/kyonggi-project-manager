package com.me.projectmanager.presentation.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class UserDto {

  private Long id;

  private String username;

  private String name;

  private String profile;
}
