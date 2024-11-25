package com.me.projectmanager.presentation;

import com.me.projectmanager.domain.Task.Priority;
import com.me.projectmanager.domain.Task.Status;
import com.me.projectmanager.presentation.dto.ChangeTaskStatusRequest;
import com.me.projectmanager.presentation.dto.ProjectDto;
import com.me.projectmanager.presentation.dto.ProjectSummaryDto;
import com.me.projectmanager.presentation.dto.TaskDto;
import jakarta.servlet.http.HttpSession;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
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

  private static final String USER_SESSION_KEY = "loggedInUser";

  private static final List<TaskDto> taskDtos = new ArrayList<>(List.of(
      new TaskDto("1", "knowk", "1", "Task 1",
                  "body detail\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ntoo long...",
                  Status.TODO, Priority.MEDIUM,
                  "Frontend", "user1Profile", "user1", "user2Profile", "user2",
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("2", "knowk", "1", "Task 2", "body detail\n\n\ntoo long...", Status.TODO,
                  Priority.LOW, "Backend", "user2Profile", "user2", "user3Profile",
                  "user3", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("3", "knowk", "1", "Task 3", "body detail\n\n\ntoo long...", Status.TODO,
                  Priority.HIGH, "Backend", "user3Profile", "user3", "user4Profile",
                  "user4", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("4", "knowk", "1", "Task 4", "body detail\n\n\ntoo long...", Status.TODO,
                  Priority.MEDIUM, "Frontend", "user4Profile", "user4", "user5Profile",
                  "user5", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("5", "knowk", "1", "Task 5", "body detail\n\n\ntoo long...", Status.IN_PROGRESS,
                  Priority.MEDIUM, "Backend", "user5Profile", "user5", "user6Profile",
                  "user6", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter)),
      new TaskDto("6", "knowk", "1", "Task 6", "body detail\n\n\ntoo long...", Status.DONE,
                  Priority.MEDIUM, "Backend", "user6Profile", "user6", "user2Profile",
                  "user2", OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter),
                  OffsetDateTime.now(ZoneId.of("Asia/Seoul")).format(formatter))
  ));

  public static final List<ProjectDto> projectDtos = List.of(
      new ProjectDto("1", "knowk"),
      new ProjectDto("2", "vroong"),
      new ProjectDto("3", "manna"),
      new ProjectDto("4", "manna2")
  );

  @GetMapping("/")
  public String home(Model model) {
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
        .filter(taskDto -> taskDto.getPersonInCharge().equals("user2")).toList();

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

    if ("admin".equals(username) && "password".equals(password)) {
      session.setAttribute(USER_SESSION_KEY, username);
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

  @PostMapping("/addTask")
  public HttpEntity<TaskDto> addTask(@RequestBody TaskDto taskDto) {
    taskDto.setId(String.valueOf(taskDtos.size() + 1));

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

  @PostMapping("/api/projects/{projectId}/tasks/{taskId}/status")
  public HttpEntity<Void> updateTaskStatus(@PathVariable String projectId, @PathVariable String taskId,
                                           @RequestBody ChangeTaskStatusRequest request) {
    taskDtos.stream().filter(taskDto -> taskDto.getProjectId().equals(projectId) && taskDto.getId().equals(taskId))
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
