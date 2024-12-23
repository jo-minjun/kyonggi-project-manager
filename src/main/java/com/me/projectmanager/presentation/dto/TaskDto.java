package com.me.projectmanager.presentation.dto;

import com.me.projectmanager.domain.Task.Priority;
import com.me.projectmanager.domain.Task.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TaskDto {

  private Long id;

  private String key;

  private String projectName;

  private Long projectId;

  private String title;

  private String body;

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
