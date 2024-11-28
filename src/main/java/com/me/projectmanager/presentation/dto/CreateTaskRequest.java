package com.me.projectmanager.presentation.dto;

import com.me.projectmanager.domain.Task.Priority;
import com.me.projectmanager.domain.Task.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateTaskRequest {

  private String title;

  private String body;

  private Status status;

  private Priority priority;

  private String label;

  private String personInCharge;

  private String dueDate;
}
