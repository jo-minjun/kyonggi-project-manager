package com.me.projectmanager.domain.command;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateUserCommand {

  private final String username;

  private final String password;

  private final String name;
}
