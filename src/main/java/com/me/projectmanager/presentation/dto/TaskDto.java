package com.me.projectmanager.presentation.dto;

import com.me.projectmanager.domain.Task.Priority;
import com.me.projectmanager.domain.Task.Status;
import java.time.OffsetDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@AllArgsConstructor
public class TaskDto {

  @Setter
  private String id;

  private String projectName;

  private String projectId;

  private String title;

  private String body;

  @Setter
  private Status status;

  private Priority priority;

  private String label;

  private String createdByProfile;

  private String createdBy;

  private String personInChargeProfile;

  private String personInCharge;

  private String createdDate;

  private String dueDate;
}
