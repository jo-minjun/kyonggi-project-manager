package com.me.projectmanager.presentation.dto;

import com.me.projectmanager.domain.Task.Priority;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChangeTaskPriorityRequest {

  private Priority priority;
}
