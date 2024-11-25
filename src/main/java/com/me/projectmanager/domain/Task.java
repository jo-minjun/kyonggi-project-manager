package com.me.projectmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class Task {

  private Long id;

  private String title;

  private Status status;

  private Priority priority;

  private Long projectId;

  public enum Priority {
    LOW, MEDIUM, HIGH
  }

  public enum Status {
    TODO, IN_PROGRESS, DONE
  }
}
