package com.me.projectmanager.application;

import com.me.projectmanager.domain.Task;
import com.me.projectmanager.domain.command.ChangeTaskBodyCommand;
import com.me.projectmanager.domain.command.ChangeTaskStatusCommand;
import com.me.projectmanager.domain.command.ChangeTaskTitleCommand;
import com.me.projectmanager.domain.command.CreateTaskCommand;
import com.me.projectmanager.domain.repository.TaskRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class TaskService {

  private final TaskRepository taskRepository;

  @Transactional(readOnly = true)
  public List<Task> findAllByPersonInCharge(String personInCharge) {
    return taskRepository.findAll().stream()
        .filter(task -> task.getPersonInCharge().equals(personInCharge))
        .toList();
  }

  @Transactional(readOnly = true)
  public List<Task> findAllByProjectId(Long projectId) {
    return taskRepository.findAll().stream()
        .filter(task -> task.getProjectId().equals(projectId))
        .toList();
  }

  @Transactional
  public Task create(CreateTaskCommand command) {
    Task task = Task.createFrom(command);

    return taskRepository.create(task);
  }

  @Transactional
  public void changeTaskStatus(Long projectId, String taskKey, ChangeTaskStatusCommand command) {
    Task task = taskRepository.findAll().stream()
        .filter(t -> t.getProjectId().equals(projectId))
        .filter(t -> t.getKey().equals(taskKey))
        .findFirst()
        .orElseThrow();

    task.changeStatus(command.getStatus());

    taskRepository.update(task);
  }

  @Transactional
  public void changeTaskBody(Long projectId, String taskKey, ChangeTaskBodyCommand command) {
    Task task = taskRepository.findAll().stream()
        .filter(t -> t.getProjectId().equals(projectId))
        .filter(t -> t.getKey().equals(taskKey))
        .findFirst()
        .orElseThrow();

    task.changeBody(command.getBody());

    taskRepository.update(task);
  }

  @Transactional
  public void changeTaskTitle(Long projectId, String taskKey, ChangeTaskTitleCommand command) {
    Task task = taskRepository.findAll().stream()
        .filter(t -> t.getProjectId().equals(projectId))
        .filter(t -> t.getKey().equals(taskKey))
        .findFirst()
        .orElseThrow();

    task.changeTitle(command.getTitle());

    taskRepository.update(task);
  }

  @Transactional(readOnly = true)
  public List<Task> searchByKeyword(String query) {
    return taskRepository.findAll().stream()
        .filter(
            task -> task.getTitle().contains(query) || task.getBody().contains(query))
        .toList();
  }
}
