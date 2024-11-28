package com.me.projectmanager.domain.command;

import com.me.projectmanager.domain.Task.Priority;
import com.me.projectmanager.domain.Task.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@AllArgsConstructor
public class CreateTaskCommand {

  @Setter
  private String key;

  @Setter
  private Long projectId;

  private String title;

  private String body;

  private Status status;

  private Priority priority;

  private String label;

  @Setter
  private String createdBy;

  private String personInCharge;

  private String createdDate;

  private String dueDate;
}
