package com.me.projectmanager.infrastructure.mapper;

import com.me.projectmanager.domain.Project;
import com.me.projectmanager.infrastructure.entity.ProjectEntity;

public interface ProjectEntityMapper {

  static ProjectEntity toProjectEntity(Project project) {
    return new ProjectEntity(project.getId(), project.getName(), project.getKey(),
                             project.getLeader(), project.getDescription());
  }

  static Project toProject(ProjectEntity projectEntity) {
    return new Project(projectEntity.getId(), projectEntity.getName(), projectEntity.getKey(),
                       projectEntity.getLeader(), projectEntity.getDescription());
  }
}
