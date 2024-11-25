package com.me.projectmanager.presentation.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ProjectSummaryDto {

  private String projectId;

  private String projectName;

  private long numOfTodo;

  private long numOfInProgress;

  private long numOfDone;
}
