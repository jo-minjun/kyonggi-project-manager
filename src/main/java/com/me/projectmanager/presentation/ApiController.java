package com.me.projectmanager.presentation;

import com.me.projectmanager.application.ProjectService;
import com.me.projectmanager.application.TaskService;
import com.me.projectmanager.application.UserService;
import com.me.projectmanager.domain.Project;
import com.me.projectmanager.domain.Task;
import com.me.projectmanager.domain.command.ChangeTaskStatusCommand;
import com.me.projectmanager.domain.command.CreateTaskCommand;
import com.me.projectmanager.presentation.dto.ChangeTaskStatusRequest;
import com.me.projectmanager.presentation.dto.CreateProjectRequest;
import com.me.projectmanager.presentation.dto.CreateTaskRequest;
import com.me.projectmanager.presentation.dto.ProjectDto;
import com.me.projectmanager.presentation.dto.TaskDto;
import com.me.projectmanager.presentation.mapper.ProjectDtoMapper;
import com.me.projectmanager.presentation.mapper.TaskDtoMapper;
import jakarta.servlet.http.HttpSession;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
@RequiredArgsConstructor
public class ApiController {

  private final ProjectService projectService;
  private final TaskService taskService;
  private final UserService userService;

  public static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 M월 d일");

  public static final String SESSION_KEY = "loggedInUser";
  public static final String NAME_SESSION_KEY = "loggedInUserName";

  @PostMapping("/api/projects")
  public HttpEntity<ProjectDto> createProject(@RequestBody CreateProjectRequest request) {
    Project project = projectService.create(ProjectDtoMapper.toCreateProjectCommand(request));

    return ResponseEntity.ok(ProjectDtoMapper.toProjectDto(project));
  }

  @GetMapping("/api/projects")
  public HttpEntity<List<ProjectDto>> getProjects() {
    List<Project> projects = projectService.findAll();

    return ResponseEntity.ok(projects.stream().map(ProjectDtoMapper::toProjectDto).toList());
  }

  @PostMapping("/api/projects/{projectId}/tasks")
  public HttpEntity<TaskDto> addTask(@PathVariable Long projectId, @RequestBody CreateTaskRequest request, HttpSession session) {
    Project project = projectService.findById(projectId);
    List<Task> tasks = taskService.findAllByProjectId(projectId).stream()
        .sorted(Comparator.comparing(Task::getId))
        .toList();

    Long lastId = tasks.isEmpty() ? 0 : tasks.getLast().getId();

    CreateTaskCommand command = TaskDtoMapper.toCreateTaskCommand(request);
    command.setProjectId(projectId);
    command.setKey(project.getKey() + "-" + (lastId + 1));
    command.setCreatedBy((String) session.getAttribute(SESSION_KEY));

    Task task = taskService.create(command);

    return ResponseEntity.ok(mapTaskDto(task));
  }

  @GetMapping("/api/projects/{projectId}/tasks/{taskKey}")
  public HttpEntity<TaskDto> getTaskDetails(@PathVariable Long projectId, @PathVariable String taskKey) {
    Optional<TaskDto> taskDtoOptional = taskService.findAllByProjectId(projectId)
        .stream()
        .filter(task -> task.getKey().equals(taskKey))
        .map(this::mapTaskDto)
        .findFirst();

    return taskDtoOptional.<HttpEntity<TaskDto>>map(ResponseEntity::ok)
        .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());

  }

  @GetMapping("/api/me/tasks")
  public HttpEntity<List<TaskDto>> getMyTasks(HttpSession session, Model model) {
    List<TaskDto> taskDtos = taskService.findAllByPersonInCharge(
            (String) session.getAttribute(SESSION_KEY))
        .stream()
        .map(this::mapTaskDto)
        .toList();

    model.addAttribute("tasks", taskDtos);

    return ResponseEntity.ok(taskDtos);
  }

  @PostMapping("/api/projects/{projectId}/tasks/{taskKey}/status")
  public HttpEntity<Void> updateTaskStatus(@PathVariable Long projectId,
                                           @PathVariable String taskKey,
                                           @RequestBody ChangeTaskStatusRequest request) {

    ChangeTaskStatusCommand command = TaskDtoMapper.toChangeTaskStatusCommand(request);

    taskService.changeTaskStatus(projectId, taskKey, command);

    return ResponseEntity.ok().build();
  }

  private TaskDto mapTaskDto(Task userTask) {
    return TaskDtoMapper.toTaskDto(userTask,
                                   projectService.findById(userTask.getProjectId()),
                                   userService.findByUsername(
                                       userTask.getCreatedBy()),
                                   userService.findByUsername(
                                       userTask.getPersonInCharge()));
  }
}
