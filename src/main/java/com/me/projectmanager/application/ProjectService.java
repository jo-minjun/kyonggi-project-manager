package com.me.projectmanager.application;

import com.me.projectmanager.domain.CreateProjectCommand;
import com.me.projectmanager.domain.Project;
import com.me.projectmanager.domain.repository.ProjectRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ProjectService {

  private final ProjectRepository projectRepository;

  @Transactional
  public Project create(CreateProjectCommand command) {
    Project project = Project.createFrom(command);

    return projectRepository.create(project);
  }

  @Transactional
  public Project findById(Long id) {
    return projectRepository.findById(id).get();
  }

  public List<Project> findAll() {
    return projectRepository.findAll();
  }
}
