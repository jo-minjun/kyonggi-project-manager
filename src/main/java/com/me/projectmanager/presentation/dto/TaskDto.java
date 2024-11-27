package com.me.projectmanager.presentation.dto;

import com.me.projectmanager.domain.Task.Priority;
import com.me.projectmanager.domain.Task.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@AllArgsConstructor
public class TaskDto {

  @Setter
  private String id;

  private String projectName;

  @Setter
  private Long projectId;

  private String title;

  private String body;

  @Setter
  private Status status;

  private Priority priority;

  private String label;

  private String createdByProfile;

  @Setter
  private String createdBy;

  private String personInChargeProfile;

  private String personInCharge;

  private String createdDate;

  private String dueDate;
}
