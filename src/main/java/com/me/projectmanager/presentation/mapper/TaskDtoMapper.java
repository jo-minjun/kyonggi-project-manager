package com.me.projectmanager.presentation.mapper;

import com.me.projectmanager.domain.Project;
import com.me.projectmanager.domain.Task;
import com.me.projectmanager.domain.User;
import com.me.projectmanager.domain.command.ChangeTaskAssigneeCommand;
import com.me.projectmanager.domain.command.ChangeTaskBodyCommand;
import com.me.projectmanager.domain.command.ChangeTaskDueDateCommand;
import com.me.projectmanager.domain.command.ChangeTaskPriorityCommand;
import com.me.projectmanager.domain.command.ChangeTaskStatusCommand;
import com.me.projectmanager.domain.command.ChangeTaskTitleCommand;
import com.me.projectmanager.domain.command.CreateTaskCommand;
import com.me.projectmanager.presentation.dto.ChangeTaskAssigneeRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskBodyRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskDueDateRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskPriorityRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskStatusRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskTitleRequest;
import com.me.projectmanager.presentation.dto.CreateTaskRequest;
import com.me.projectmanager.presentation.dto.TaskDto;
import java.time.OffsetDateTime;

public interface TaskDtoMapper {

  static TaskDto toTaskDto(Task task, Project project, User createdBy, User personInCharge) {
    return TaskDto.builder()
        .id(task.getId())
        .key(task.getKey())
        .projectName(project.getName())
        .projectId(project.getId())
        .title(task.getTitle())
        .body(task.getBody())
        .status(task.getStatus())
        .priority(task.getPriority())
        .label(task.getLabel())
        .createdByProfile(createdBy.getProfile())
        .createdBy(task.getCreatedBy())
        .personInChargeProfile(personInCharge.getProfile())
        .personInCharge(task.getPersonInCharge())
        .createdDate(task.getCreatedDate())
        .dueDate(task.getDueDate())
        .build();
  }

  static CreateTaskCommand toCreateTaskCommand(CreateTaskRequest request) {
    return new CreateTaskCommand(null, null, request.getTitle(), request.getBody(), request.getStatus(),
                                 request.getPriority(), request.getLabel(), null, request.getPersonInCharge(),
                                 OffsetDateTime.now().toLocalDate().toString(), request.getDueDate());
  }

  static ChangeTaskStatusCommand toChangeTaskStatusCommand(ChangeTaskStatusRequest request) {
    return new ChangeTaskStatusCommand(request.getStatus());
  }

  static ChangeTaskAssigneeCommand toChangeTaskAssigneeCommand(ChangeTaskAssigneeRequest request) {
    return new ChangeTaskAssigneeCommand(request.getPersonInCharge());
  }

  static ChangeTaskBodyCommand toChangeTaskBodyCommand(ChangeTaskBodyRequest request) {
    return new ChangeTaskBodyCommand(request.getBody());
  }

  static ChangeTaskDueDateCommand toChangeTaskDueDateCommand(ChangeTaskDueDateRequest request) {
    return new ChangeTaskDueDateCommand(request.getDueDate());
  }

  static ChangeTaskTitleCommand toChangeTaskTitleCommand(ChangeTaskTitleRequest request) {
    return new ChangeTaskTitleCommand(request.getTitle());
  }

  static ChangeTaskPriorityCommand toChangeTaskPriorityCommand(ChangeTaskPriorityRequest request) {
    return new ChangeTaskPriorityCommand(request.getPriority());
  }
}
