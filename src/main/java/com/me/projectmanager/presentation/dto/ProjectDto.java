package com.me.projectmanager.presentation.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ProjectDto {

  private Long id;

  private String key;

  private String name;

  private String description;
}
