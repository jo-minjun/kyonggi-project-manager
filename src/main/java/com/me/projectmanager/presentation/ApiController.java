package com.me.projectmanager.presentation;

import com.me.projectmanager.application.ProjectService;
import com.me.projectmanager.domain.Project;
import com.me.projectmanager.domain.Task.Priority;
import com.me.projectmanager.domain.Task.Status;
import com.me.projectmanager.presentation.dto.ChangeTaskStatusRequest;
import com.me.projectmanager.presentation.dto.CreateProjectRequest;
import com.me.projectmanager.presentation.dto.ProjectDto;
import com.me.projectmanager.presentation.dto.TaskDto;
import com.me.projectmanager.presentation.dto.UserDto;
import com.me.projectmanager.presentation.mapper.ProjectDtoMapper;
import jakarta.servlet.http.HttpSession;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
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

  public static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 M월 d일");

  public static final String SESSION_KEY = "loggedInUser";
  public static final String NAME_SESSION_KEY = "loggedInUserName";

  public static final List<UserDto> userDtos = new ArrayList<>(List.of(
      new UserDto(1L, "admin", "password", "관리자", null)
  ));

  public static final List<TaskDto> taskDtos = new ArrayList<>(List.of(
      new TaskDto("1", "knowk", 1L, "Task 1",
                  "body detail\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ntoo long...",
                  Status.TODO, Priority.MEDIUM,
                  "Frontend", "/resources/image/profile.svg", "admin", "/resources/image/profile.svg", "admin",
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("2", "knowk", 1L, "Task 2", "body detail\n\n\ntoo long...", Status.TODO,
                  Priority.LOW, "Backend", "/resources/image/profile.svg", "admin", "/resources/image/profile.svg",
                  "admin", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("3", "knowk", 1L, "Task 3", "body detail\n\n\ntoo long...", Status.TODO,
                  Priority.HIGH, "Backend", "/resources/image/profile.svg", "admin", "/resources/image/profile.svg",
                  "admin", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("4", "knowk", 1L, "Task 4", "body detail\n\n\ntoo long...", Status.TODO,
                  Priority.MEDIUM, "Frontend", "/resources/image/profile.svg", "admin", "/resources/image/profile.svg",
                  "admin", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("5", "knowk", 1L, "Task 5", "body detail\n\n\ntoo long...", Status.IN_PROGRESS,
                  Priority.MEDIUM, "Backend", "/resources/image/profile.svg", "admin2", "/resources/image/profile.svg",
                  "admin2", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("6", "knowk", 1L, "Task 6", "body detail\n\n\ntoo long...", Status.DONE,
                  Priority.MEDIUM, "Backend", "/resources/image/profile.svg", "admin", "/resources/image/profile.svg",
                  "admin", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter))
  ));

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
  public HttpEntity<TaskDto> addTask(@PathVariable Long projectId, @RequestBody TaskDto taskDto, HttpSession session) {
    ProjectDto projectDto = ProjectDtoMapper.toProjectDto(projectService.findById(projectId));

    taskDto.setId(projectDto.getKey() + "-" + (taskDtos.size() + 1));
    taskDto.setCreatedBy((String) session.getAttribute(NAME_SESSION_KEY));
    taskDto.setProjectId(projectId);

    taskDtos.add(taskDto);

    return ResponseEntity.ok(taskDto);
  }

  @GetMapping("/api/projects/{projectId}/tasks/{taskId}")
  public HttpEntity<TaskDto> getTaskDetails(@PathVariable Long projectId, @PathVariable String taskId) {
    TaskDto taskDto = taskDtos.stream()
        .filter(task -> task.getProjectId().equals(projectId) && task.getId().equals(taskId))
        .findFirst()
        .orElse(null);

    if (taskDto == null) {
      return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    return ResponseEntity.ok(taskDto);
  }

  @GetMapping("/api/me/tasks")
  public HttpEntity<List<TaskDto>> getMyTasks(HttpSession session, Model model) {
    List<TaskDto> userTaskDtos = taskDtos.stream()
        .filter(taskDto -> taskDto.getPersonInCharge().equals(session.getAttribute(SESSION_KEY))).toList();

    model.addAttribute("tasks", userTaskDtos);

    return ResponseEntity.ok(userTaskDtos);
  }

  @PostMapping("/api/projects/{projectId}/tasks/{taskId}/status")
  public HttpEntity<Void> updateTaskStatus(@PathVariable Long projectId,
                                           @PathVariable String taskId,
                                           @RequestBody ChangeTaskStatusRequest request) {
    taskDtos.stream().filter(
            taskDto -> taskDto.getProjectId().equals(projectId) && taskDto.getId().equals(taskId))
        .findFirst()
        .ifPresent(taskDto -> taskDto.setStatus(request.getStatus()));

    return ResponseEntity.ok().build();
  }
}
