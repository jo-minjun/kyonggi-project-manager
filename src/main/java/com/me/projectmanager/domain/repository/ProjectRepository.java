package com.me.projectmanager.domain.repository;

import com.me.projectmanager.domain.Project;
import java.util.List;
import java.util.Optional;

public interface ProjectRepository {

  Project create(Project project);

  Optional<Project> findById(Long id);

  List<Project> findAll();
}
