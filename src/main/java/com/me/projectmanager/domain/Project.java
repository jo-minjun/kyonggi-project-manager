package com.me.projectmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class Project {

  private Long id;

  private String name;

  private String key;

  private String leader;

  private String description;

  public static Project createFrom(CreateProjectCommand command) {
    return new Project(null, command.getName(), command.getKey(), command.getLeader(),
                       command.getDescription());
  }
}
