package com.me.projectmanager.infrastructure.repository;

import com.me.projectmanager.domain.Project;
import com.me.projectmanager.domain.repository.ProjectRepository;
import com.me.projectmanager.infrastructure.mapper.ProjectEntityMapper;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class ProjectRepositoryImpl implements ProjectRepository {

  private final ProjectEntityRepository projectEntityRepository;

  @Override
  public Project create(Project project) {
    return ProjectEntityMapper.toProject(
        projectEntityRepository.save(ProjectEntityMapper.toProjectEntity(project)));
  }

  @Override
  public Optional<Project> findById(Long id) {
    return projectEntityRepository.findById(id).map(ProjectEntityMapper::toProject);
  }

  @Override
  public List<Project> findAll() {
    return projectEntityRepository.findAll().stream().map(ProjectEntityMapper::toProject).toList();
  }
}
