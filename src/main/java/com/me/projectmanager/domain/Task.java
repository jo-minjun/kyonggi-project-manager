package com.me.projectmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class Task {

  private Long id;

  private Long projectId;

  private String title;

  private String body;

  private Status status;

  private Priority priority;

  private String label;

  private String createdBy;

  private String personInCharge;

  private String createdDate;

  private String dueDate;

  public enum Priority {
    LOW, MEDIUM, HIGH;
  }

  public enum Status {
    TODO, IN_PROGRESS, DONE
  }
}
