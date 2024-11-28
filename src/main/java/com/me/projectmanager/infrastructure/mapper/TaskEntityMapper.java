package com.me.projectmanager.infrastructure.mapper;

import com.me.projectmanager.domain.Task;
import com.me.projectmanager.infrastructure.entity.TaskEntity;

public interface TaskEntityMapper {

  static TaskEntity toTaskEntity(Task task) {
    return new TaskEntity(
        task.getId(),
        task.getKey(),
        task.getProjectId(),
        task.getTitle(),
        task.getBody(),
        task.getStatus(),
        task.getPriority(),
        task.getLabel(),
        task.getCreatedBy(),
        task.getPersonInCharge(),
        task.getCreatedDate(),
        task.getDueDate()
    );
  }

  static Task toTask(TaskEntity taskEntity) {
    return new Task(
        taskEntity.getId(),
        taskEntity.getKey(),
        taskEntity.getProjectId(),
        taskEntity.getTitle(),
        taskEntity.getBody(),
        taskEntity.getStatus(),
        taskEntity.getPriority(),
        taskEntity.getLabel(),
        taskEntity.getCreatedBy(),
        taskEntity.getPersonInCharge(),
        taskEntity.getCreatedDate(),
        taskEntity.getDueDate()
    );
  }
}
