package com.me.projectmanager.presentation;

import com.me.projectmanager.application.ProjectService;
import com.me.projectmanager.application.TaskService;
import com.me.projectmanager.application.UserService;
import com.me.projectmanager.domain.Project;
import com.me.projectmanager.domain.Task;
import com.me.projectmanager.domain.User;
import com.me.projectmanager.domain.command.ChangeTaskAssigneeCommand;
import com.me.projectmanager.domain.command.ChangeTaskBodyCommand;
import com.me.projectmanager.domain.command.ChangeTaskDueDateCommand;
import com.me.projectmanager.domain.command.ChangeTaskLabelCommand;
import com.me.projectmanager.domain.command.ChangeTaskPriorityCommand;
import com.me.projectmanager.domain.command.ChangeTaskStatusCommand;
import com.me.projectmanager.domain.command.ChangeTaskTitleCommand;
import com.me.projectmanager.domain.command.CreateTaskCommand;
import com.me.projectmanager.presentation.dto.ChangeTaskAssigneeRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskBodyRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskDueDateRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskLabelRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskPriorityRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskStatusRequest;
import com.me.projectmanager.presentation.dto.ChangeTaskTitleRequest;
import com.me.projectmanager.presentation.dto.CreateProjectRequest;
import com.me.projectmanager.presentation.dto.CreateTaskRequest;
import com.me.projectmanager.presentation.dto.ProjectDto;
import com.me.projectmanager.presentation.dto.TaskDto;
import com.me.projectmanager.presentation.dto.UserDto;
import com.me.projectmanager.presentation.mapper.ProjectDtoMapper;
import com.me.projectmanager.presentation.mapper.TaskDtoMapper;
import com.me.projectmanager.presentation.mapper.UserDtoMapper;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequiredArgsConstructor
public class ApiController {

  private final ProjectService projectService;
  private final TaskService taskService;
  private final UserService userService;

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
  public HttpEntity<TaskDto> addTask(@PathVariable Long projectId,
                                     @RequestBody CreateTaskRequest request, HttpSession session) {
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
  public HttpEntity<TaskDto> getTaskDetails(@PathVariable Long projectId,
                                            @PathVariable String taskKey) {
    Optional<TaskDto> taskDtoOptional = taskService.findAllByProjectId(projectId)
        .stream()
        .filter(task -> task.getKey().equals(taskKey))
        .map(this::mapTaskDto)
        .findFirst();

    return taskDtoOptional.<HttpEntity<TaskDto>>map(ResponseEntity::ok)
        .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());

  }

  @PatchMapping("/api/projects/{projectId}/tasks/{taskKey}/status")
  public HttpEntity<Void> updateTaskStatus(@PathVariable Long projectId,
                                           @PathVariable String taskKey,
                                           @RequestBody ChangeTaskStatusRequest request) {

    ChangeTaskStatusCommand command = TaskDtoMapper.toChangeTaskStatusCommand(request);

    taskService.changeTaskStatus(projectId, taskKey, command);

    return ResponseEntity.ok().build();
  }

  @PatchMapping("/api/projects/{projectId}/tasks/{taskKey}/priority")
  public HttpEntity<Void> updateTaskPriority(@PathVariable Long projectId,
                                           @PathVariable String taskKey,
                                           @RequestBody ChangeTaskPriorityRequest request) {

    ChangeTaskPriorityCommand command = TaskDtoMapper.toChangeTaskPriorityCommand(request);

    taskService.changeTaskPriority(projectId, taskKey, command);

    return ResponseEntity.ok().build();
  }

  @PatchMapping("/api/projects/{projectId}/tasks/{taskKey}/assignee")
  public HttpEntity<Void> updateTaskAssignee(@PathVariable Long projectId,
                                             @PathVariable String taskKey,
                                             @RequestBody ChangeTaskAssigneeRequest request) {

    ChangeTaskAssigneeCommand command = TaskDtoMapper.toChangeTaskAssigneeCommand(request);

    taskService.changeTaskAssignee(projectId, taskKey, command);

    return ResponseEntity.ok().build();
  }

  @PatchMapping("/api/projects/{projectId}/tasks/{taskKey}/due-date")
  public HttpEntity<Void> updateTaskDueDate(@PathVariable Long projectId,
                                             @PathVariable String taskKey,
                                             @RequestBody ChangeTaskDueDateRequest request) {

    ChangeTaskDueDateCommand command = TaskDtoMapper.toChangeTaskDueDateCommand(request);

    taskService.changeTaskDueDate(projectId, taskKey, command);

    return ResponseEntity.ok().build();
  }

  @PatchMapping("/api/projects/{projectId}/tasks/{taskKey}/label")
  public HttpEntity<Void> updateTaskLabel(@PathVariable Long projectId,
                                            @PathVariable String taskKey,
                                            @RequestBody ChangeTaskLabelRequest request) {

    ChangeTaskLabelCommand command = TaskDtoMapper.toChangeTaskLabelCommand(request);

    taskService.changeTaskLabel(projectId, taskKey, command);

    return ResponseEntity.ok().build();
  }


  @PatchMapping("/api/projects/{projectId}/tasks/{taskKey}/body")
  public HttpEntity<Void> updateTaskBody(@PathVariable Long projectId,
                                         @PathVariable String taskKey,
                                         @RequestBody ChangeTaskBodyRequest request) {

    ChangeTaskBodyCommand command = TaskDtoMapper.toChangeTaskBodyCommand(request);

    taskService.changeTaskBody(projectId, taskKey, command);

    return ResponseEntity.ok().build();
  }

  @PatchMapping("/api/projects/{projectId}/tasks/{taskKey}/title")
  public HttpEntity<Void> updateTaskTitle(@PathVariable Long projectId,
                                          @PathVariable String taskKey,
                                          @RequestBody ChangeTaskTitleRequest request) {

    ChangeTaskTitleCommand command = TaskDtoMapper.toChangeTaskTitleCommand(request);

    taskService.changeTaskTitle(projectId, taskKey, command);

    return ResponseEntity.ok().build();
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

  @GetMapping("/api/me")
  public HttpEntity<UserDto> getProfile(HttpSession session, Model model) {
    User user = userService.findByUsername((String) session.getAttribute(SESSION_KEY));

    return ResponseEntity.ok(UserDtoMapper.toUserDto(user));
  }

  @PatchMapping("/api/me")
  public HttpEntity<Void> updateProfile(HttpSession session,
                                        @RequestParam("name") String name,
                                        @RequestParam(value = "password", required = false) String password,
                                        @RequestParam(value = "profilePicture", required = false) MultipartFile profilePicture)
      throws IOException {
    userService.updateProfile((String) session.getAttribute(SESSION_KEY), name, password,
                              profilePicture);

    return ResponseEntity.ok().build();
  }

  @GetMapping("/api/users")
  public HttpEntity<List<UserDto>> getUsers() {
    List<User> users = userService.findAll();

    return ResponseEntity.ok(users.stream().map(UserDtoMapper::toUserDto).toList());
  }

  @GetMapping("/api/tasks")
  public HttpEntity<List<TaskDto>> searchByKeyword(@RequestParam String query) {
    List<TaskDto> taskDtos = taskService.searchByKeyword(query)
        .stream()
        .map(this::mapTaskDto)
        .toList();

    return ResponseEntity.ok(taskDtos);
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
