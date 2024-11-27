package com.me.projectmanager.presentation.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateProjectRequest {

  private String name;

  private String key;

  private String leader;

  private String description;
}
