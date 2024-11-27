package com.me.projectmanager.presentation;

import static com.me.projectmanager.presentation.ApiController.*;

import com.me.projectmanager.application.ProjectService;
import com.me.projectmanager.domain.Project;
import com.me.projectmanager.domain.Task.Status;
import com.me.projectmanager.presentation.dto.ProjectSummaryDto;
import com.me.projectmanager.presentation.dto.TaskDto;
import com.me.projectmanager.presentation.dto.UserDto;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class PageController {

  private final ProjectService projectService;

  @GetMapping("/")
  public String home(Model model, HttpSession session) {
    List<Project> projects = projectService.findAll();

    List<ProjectSummaryDto> projectSummaryDtos = projects.stream()
        .map(project -> new ProjectSummaryDto(project.getId(), project.getName(),
                                                 countByProjectIdAndStatus(project.getId(),
                                                                           Status.TODO),
                                                 countByProjectIdAndStatus(project.getId(),
                                                                           Status.IN_PROGRESS),
                                                 countByProjectIdAndStatus(project.getId(),
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
  public String getProject(@PathVariable Long projectId, Model model) {
    model.addAttribute("tasks",
                       taskDtos.stream().filter(taskDto -> taskDto.getProjectId().equals(projectId))
                           .toList());
    model.addAttribute("personFilters", taskDtos.stream().map(TaskDto::getPersonInCharge).collect(
        Collectors.toSet()));
    model.addAttribute("labelFilters", taskDtos.stream().map(TaskDto::getLabel).collect(
        Collectors.toSet()));

    return "project";
  }

  @GetMapping("/projects/{projectId}/tasks/{taskId}")
  public String getTaskDetailPage(@PathVariable Long projectId, @PathVariable String taskId, Model model) {

    model.addAttribute("task", taskDtos.stream().filter(
            taskDto -> taskDto.getProjectId().equals(projectId) && taskDto.getId().equals(taskId))
        .findFirst().get());

    return "taskDetail";
  }

  @GetMapping("/users/{userId}")
  public String getUserPage(@PathVariable String userId, Model model) {
    model.addAttribute("user", userDtos.stream().filter(userDto -> userDto.getUsername().equals(userId)).findFirst()
        .get());

    return "edit-profile";
  }

  private long countByProjectIdAndStatus(Long id, Status status) {
    return taskDtos.stream()
        .filter(taskDto -> taskDto.getStatus() == status && taskDto.getProjectId().equals(id))
        .count();
  }
}
