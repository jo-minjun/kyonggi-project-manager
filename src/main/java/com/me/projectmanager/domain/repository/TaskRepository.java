package com.me.projectmanager.domain.repository;

import com.me.projectmanager.domain.Task;
import java.util.List;
import java.util.Optional;

public interface TaskRepository {

  List<Task> findAll();

  Optional<Task> findByKey(String id);

  Task create(Task task);

  void deleteByKey(String id);

  void update(Task task);
}
