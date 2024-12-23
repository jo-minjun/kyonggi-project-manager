package com.me.projectmanager.domain;

import com.me.projectmanager.domain.command.CreateTaskCommand;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class Task {

  private Long id;

  private String key;

  private Long projectId;

  private String title;

  private String body;

  private Status status;

  private Priority priority;

  private String label;

  private String createdBy;

  private String personInCharge;

  private String createdDate;

  private String dueDate;

  public static Task createFrom(CreateTaskCommand command) {
    return new Task(
        null,
        command.getKey(),
        command.getProjectId(),
        command.getTitle(),
        command.getBody(),
        Status.TODO,
        command.getPriority(),
        command.getLabel(),
        command.getCreatedBy(),
        command.getPersonInCharge(),
        command.getCreatedDate(),
        command.getDueDate()
    );
  }

  public void changeStatus(Status status) {
    this.status = status;
  }

  public void changePriority(Priority priority) {
    this.priority = priority;
  }

  public void changeAssignee(String personInCharge) {
    this.personInCharge = personInCharge;
  }

  public void changeBody(String body) {
    this.body = body;
  }

  public void changeTitle(String title) {
    this.title = title;
  }

  public void changeDueDate(String dueDate) {
    this.dueDate = dueDate;
  }

  public void changeLabel(String label) {
    this.label = label;
  }

  public enum Priority {
    LOW, MEDIUM, HIGH;
  }

  public enum Status {
    TODO, IN_PROGRESS, DONE
  }
}
