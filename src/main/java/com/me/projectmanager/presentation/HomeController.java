package com.me.projectmanager.presentation;

import com.me.projectmanager.domain.Task.Priority;
import com.me.projectmanager.domain.Task.Status;
import com.me.projectmanager.presentation.dto.ChangeTaskStatusRequest;
import com.me.projectmanager.presentation.dto.CreateProjectRequest;
import com.me.projectmanager.presentation.dto.ProjectDto;
import com.me.projectmanager.presentation.dto.ProjectSummaryDto;
import com.me.projectmanager.presentation.dto.TaskDto;
import com.me.projectmanager.presentation.dto.UserDto;
import jakarta.servlet.http.HttpSession;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

  private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 M월 d일");

  private static final String SESSION_KEY = "loggedInUser";
  private static final String NAME_SESSION_KEY = "loggedInUserName";

  private static final List<UserDto> userDtos = new ArrayList<>(List.of(
      new UserDto(1L, "admin", "password", "관리자", null)
  ));

  private static final List<TaskDto> taskDtos = new ArrayList<>(List.of(
      new TaskDto("1", "knowk", "1", "Task 1",
                  "body detail\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ntoo long...",
                  Status.TODO, Priority.MEDIUM,
                  "Frontend", "user1Profile", "admin", "user2Profile", "admin",
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("2", "knowk", "1", "Task 2", "body detail\n\n\ntoo long...", Status.TODO,
                  Priority.LOW, "Backend", "user2Profile", "admin", "user3Profile",
                  "admin", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("3", "knowk", "1", "Task 3", "body detail\n\n\ntoo long...", Status.TODO,
                  Priority.HIGH, "Backend", "user3Profile", "admin", "user4Profile",
                  "admin", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("4", "knowk", "1", "Task 4", "body detail\n\n\ntoo long...", Status.TODO,
                  Priority.MEDIUM, "Frontend", "user4Profile", "admin", "user5Profile",
                  "admin", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("5", "knowk", "1", "Task 5", "body detail\n\n\ntoo long...", Status.IN_PROGRESS,
                  Priority.MEDIUM, "Backend", "user5Profile", "admin2", "user6Profile",
                  "admin2", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("6", "knowk", "1", "Task 6", "body detail\n\n\ntoo long...", Status.DONE,
                  Priority.MEDIUM, "Backend", "user6Profile", "admin", "user2Profile",
                  "admin", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter))
  ));

  public static final List<ProjectDto> projectDtos = new ArrayList<>(List.of(
      new ProjectDto("1", "kw", "knowk"),
      new ProjectDto("2", "vr", "vroong"),
      new ProjectDto("3", "mn", "manna"),
      new ProjectDto("4", "mn2", "manna2")
  ));

  @GetMapping("/")
  public String home(Model model, HttpSession session) {
    List<ProjectSummaryDto> projectSummaryDtos = projectDtos.stream()
        .map(projectDto -> new ProjectSummaryDto(projectDto.getId(), projectDto.getName(),
                                                 countByProjectIdAndStatus(projectDto.getId(),
                                                                           Status.TODO),
                                                 countByProjectIdAndStatus(projectDto.getId(),
                                                                           Status.IN_PROGRESS),
                                                 countByProjectIdAndStatus(projectDto.getId(),
                                                                           Status.DONE)))
        .toList();
    List<TaskDto> userTaskDtos = taskDtos.stream()
        .filter(taskDto -> taskDto.getPersonInCharge().equals(session.getAttribute(SESSION_KEY))).toList();

    model.addAttribute("projectSummaries", projectSummaryDtos);
    model.addAttribute("tasks", userTaskDtos);

    return "index";
  }

  @GetMapping("/login")
  public String login() {
    return "login";
  }

  @PostMapping("/login")
  public String handleLogin(
      @RequestParam("username") String username,
      @RequestParam("password") String password,
      HttpSession session,
      Model model) {

    Optional<UserDto> userDtoOptional = userDtos.stream()
        .filter(userDto -> userDto.getUsername().equals(username))
        .findFirst();

    if (userDtoOptional.isPresent() && userDtoOptional.get().getPassword().equals(password)) {
      session.setAttribute(SESSION_KEY, username);
      session.setAttribute(NAME_SESSION_KEY, userDtoOptional.get().getName());
      return "redirect:/";
    } else {
      model.addAttribute("error", "username 또는 password가 올바르지 않습니다.");
      return "login"; // 로그인 페이지로 다시 이동
    }
  }

  @GetMapping("/logout")
  public String handleLogout(HttpSession session) {
    session.invalidate();

    return "redirect:/login";
  }

  @GetMapping("/signup")
  public String signup() {
    return "signup";
  }

  @PostMapping("/signup")
  public String handleSignup(@RequestParam("username") String username,
                             @RequestParam("password") String password,
                             @RequestParam("confirmPassword") String confirmPassword,
                             @RequestParam("name") String name,
                             Model model) {
    Optional<UserDto> userDtoOptional = userDtos.stream()
        .filter(userDto -> userDto.getUsername().equals(username))
        .findFirst();
    if (userDtoOptional.isPresent()) {
      model.addAttribute("error", "이미 존재하는 아이디입니다.");
      return "signup";
    }

    userDtos.add(new UserDto(userDtos.size() + 1L, username,
                             password, name, null));

    return "redirect:/login";
  }

  @GetMapping("/projects/{projectId}")
  public String getProject(@PathVariable String projectId, Model model) {
    model.addAttribute("tasks",
                       taskDtos.stream().filter(taskDto -> taskDto.getProjectId().equals(projectId))
                           .toList());
    model.addAttribute("personFilters", taskDtos.stream().map(TaskDto::getPersonInCharge).collect(
        Collectors.toSet()));
    model.addAttribute("labelFilters", taskDtos.stream().map(TaskDto::getLabel).collect(
        Collectors.toSet()));

    return "project";
  }

  @GetMapping("/api/projects")
  public HttpEntity<List<ProjectDto>> getProjects() {
    return ResponseEntity.ok(projectDtos);
  }

  @PostMapping("/api/projects")
  public HttpEntity<ProjectDto> createProject(@RequestBody CreateProjectRequest request) {
    ProjectDto projectDto = new ProjectDto(String.valueOf(projectDtos.size() + 1), request.getKey(),
                                  request.getName());
    projectDtos.add(projectDto);

    return ResponseEntity.ok(projectDto);
  }

  @PostMapping("/projects/{projectId}/tasks")
  public HttpEntity<TaskDto> addTask(@PathVariable String projectId, @RequestBody TaskDto taskDto, HttpSession session) {
    ProjectDto projectDto = projectDtos.stream()
        .filter(project -> project.getId().equals(projectId))
        .findFirst()
        .get();

    taskDto.setId(projectDto.getKey() + "-" + (taskDtos.size() + 1));
    taskDto.setCreatedBy((String) session.getAttribute(NAME_SESSION_KEY));
    taskDto.setProjectId(projectId);

    taskDtos.add(taskDto);

    return ResponseEntity.ok(taskDto);
  }

  @GetMapping("/getTaskDetails")
  public HttpEntity<TaskDto> getTaskDetails(@RequestParam String taskId) {
    TaskDto taskDto = taskDtos.stream()
        .filter(task -> task.getId().equals(taskId))
        .findFirst()
        .orElse(null);

    if (taskDto == null) {
      return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    return ResponseEntity.ok(taskDto);
  }

  @GetMapping("/projects/{projectId}/tasks/{taskId}")
  public String getTaskDetailPage(@PathVariable String projectId, @PathVariable String taskId, Model model) {

    model.addAttribute("task", taskDtos.stream().filter(
            taskDto -> taskDto.getProjectId().equals(projectId) && taskDto.getId().equals(taskId))
        .findFirst().get());

    return "taskDetail";
  }

  @GetMapping("/api/me/tasks")
  public HttpEntity<List<TaskDto>> getMyTasks(HttpSession session, Model model) {
    List<TaskDto> userTaskDtos = taskDtos.stream()
        .filter(taskDto -> taskDto.getPersonInCharge().equals(session.getAttribute(SESSION_KEY))).toList();

    model.addAttribute("tasks", userTaskDtos);

    return ResponseEntity.ok(userTaskDtos);
  }

  @PostMapping("/api/projects/{projectId}/tasks/{taskId}/status")
  public HttpEntity<Void> updateTaskStatus(@PathVariable String projectId,
                                           @PathVariable String taskId,
                                           @RequestBody ChangeTaskStatusRequest request) {
    taskDtos.stream().filter(
            taskDto -> taskDto.getProjectId().equals(projectId) && taskDto.getId().equals(taskId))
        .findFirst()
        .ifPresent(taskDto -> taskDto.setStatus(request.getStatus()));

    return ResponseEntity.ok().build();
  }

  private long countByProjectIdAndStatus(String id, Status status) {
    return taskDtos.stream()
        .filter(taskDto -> taskDto.getStatus() == status && taskDto.getProjectId().equals(id))
        .count();
  }
}
