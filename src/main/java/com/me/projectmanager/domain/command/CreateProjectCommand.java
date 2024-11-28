package com.me.projectmanager.domain.command;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateProjectCommand {

  private String name;

  private String key;

  private String leader;

  private String description;
}
