package com.me.projectmanager.domain.command;

import com.me.projectmanager.domain.Task.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ChangeTaskStatusCommand {

  private Status status;
}
