package com.me.projectmanager.presentation.dto;

import com.me.projectmanager.domain.Task.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChangeTaskStatusRequest {

  private Status status;
}
