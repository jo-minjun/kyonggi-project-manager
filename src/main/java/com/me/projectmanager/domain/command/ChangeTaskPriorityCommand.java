package com.me.projectmanager.domain.command;

import com.me.projectmanager.domain.Task.Priority;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ChangeTaskPriorityCommand {

  private Priority priority;
}
