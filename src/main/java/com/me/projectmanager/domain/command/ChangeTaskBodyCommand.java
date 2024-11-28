package com.me.projectmanager.domain.command;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ChangeTaskBodyCommand {

  private String body;
}
