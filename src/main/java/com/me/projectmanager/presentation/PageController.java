package com.me.projectmanager.presentation;

import static com.me.projectmanager.presentation.ApiController.NAME_SESSION_KEY;
import static com.me.projectmanager.presentation.ApiController.SESSION_KEY;

import com.me.projectmanager.application.ProjectService;
import com.me.projectmanager.application.TaskService;
import com.me.projectmanager.application.UserService;
import com.me.projectmanager.domain.command.CreateUserCommand;
import com.me.projectmanager.domain.Project;
import com.me.projectmanager.domain.Task;
import com.me.projectmanager.domain.Task.Status;
import com.me.projectmanager.domain.User;
import com.me.projectmanager.presentation.dto.ProjectSummaryDto;
import com.me.projectmanager.presentation.dto.TaskDto;
import com.me.projectmanager.presentation.mapper.TaskDtoMapper;
import com.me.projectmanager.presentation.mapper.UserDtoMapper;
import jakarta.servlet.http.HttpSession;
import java.util.List;
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
  private final TaskService taskService;
  private final UserService userService;

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

    List<TaskDto> taskDtos = taskService.findAllByPersonInCharge(
            (String) session.getAttribute(SESSION_KEY))
        .stream()
        .map(this::mapTaskDto)
        .toList();

    model.addAttribute("projectSummaries", projectSummaryDtos);
    model.addAttribute("tasks", taskDtos);

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
    try {
      User user = userService.login(username, password);

      session.setAttribute(SESSION_KEY, username);
      session.setAttribute(NAME_SESSION_KEY, user.getName());
      return "redirect:/";
    } catch (Exception e) {
      model.addAttribute("error", e.getMessage());
      return "login";
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
    CreateUserCommand command = UserDtoMapper.toCreateUserCommand(username, password,
                                                                  confirmPassword, name);
    try {
      userService.create(command);
    } catch (Exception e) {
      model.addAttribute("error", e.getMessage());
    }

    return "redirect:/login";
  }

  @GetMapping("/projects/{projectId}")
  public String getProject(@PathVariable Long projectId, Model model) {
    List<TaskDto> taskDtos = taskService.findAllByProjectId(projectId)
        .stream()
        .map(this::mapTaskDto)
        .toList();

    model.addAttribute("tasks", taskDtos);
    model.addAttribute("personFilters", taskDtos.stream().map(TaskDto::getPersonInCharge).collect(
        Collectors.toSet()));
    model.addAttribute("labelFilters", taskDtos.stream().map(TaskDto::getLabel).collect(
        Collectors.toSet()));

    return "project";
  }

  @GetMapping("/projects/{projectId}/tasks/{taskKey}")
  public String getTaskDetailPage(@PathVariable Long projectId, @PathVariable String taskKey,
                                  Model model) {
    TaskDto taskDto = taskService.findAllByProjectId(projectId)
        .stream()
        .filter(task -> task.getKey().equals(taskKey))
        .map(this::mapTaskDto)
        .findFirst()
        .get();

    List<User> users = userService.findAll();

    model.addAttribute("task", taskDto);
    model.addAttribute("users", users);

    return "taskDetail";
  }

  @GetMapping("/users/{username}")
  public String getUserPage(@PathVariable String username, Model model) {
    model.addAttribute("user", userService.findByUsername(username));

    return "edit-profile";
  }

  private long countByProjectIdAndStatus(Long id, Status status) {
    List<Task> tasks = taskService.findAllByProjectId(id);

    return tasks.stream()
        .filter(task -> task.getStatus() == status && task.getProjectId().equals(id))
        .count();
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
