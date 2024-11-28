package com.me.projectmanager.infrastructure.repository;

import com.me.projectmanager.domain.Task;
import com.me.projectmanager.domain.repository.TaskRepository;
import com.me.projectmanager.infrastructure.mapper.TaskEntityMapper;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class TaskRepositoryImpl implements TaskRepository {

  private final TaskEntityRepository taskEntityRepository;

  @Override
  public List<Task> findAll() {
    return taskEntityRepository.findAll().stream().map(
        TaskEntityMapper::toTask).toList();
  }

  @Override
  public Optional<Task> findByKey(String key) {
    return taskEntityRepository.findByKey(key).map(TaskEntityMapper::toTask);
  }

  @Override
  public Task create(Task task) {
    return TaskEntityMapper.toTask(taskEntityRepository.save(TaskEntityMapper.toTaskEntity(task)));
  }

  @Override
  public void deleteByKey(String id) {
    taskEntityRepository.deleteByKey(id);
  }

  @Override
  public void update(Task task) {
    taskEntityRepository.findByKey(task.getKey())
        .ifPresent(taskEntity -> taskEntityRepository.save(TaskEntityMapper.toTaskEntity(task)));
  }
}
