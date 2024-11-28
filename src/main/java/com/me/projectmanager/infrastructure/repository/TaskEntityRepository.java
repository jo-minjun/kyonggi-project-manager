package com.me.projectmanager.infrastructure.repository;

import com.me.projectmanager.infrastructure.entity.TaskEntity;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TaskEntityRepository extends JpaRepository<TaskEntity, Long> {

  Optional<TaskEntity> findByKey(String key);

  void deleteByKey(String id);
}
