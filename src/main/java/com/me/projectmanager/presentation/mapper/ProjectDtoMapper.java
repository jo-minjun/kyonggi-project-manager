package com.me.projectmanager.presentation.mapper;

import com.me.projectmanager.domain.CreateProjectCommand;
import com.me.projectmanager.domain.Project;
import com.me.projectmanager.presentation.dto.CreateProjectRequest;
import com.me.projectmanager.presentation.dto.ProjectDto;

public interface ProjectDtoMapper {

  static CreateProjectCommand toCreateProjectCommand(CreateProjectRequest request) {
    return new CreateProjectCommand(request.getName(), request.getKey(), request.getLeader(),
                                    request.getDescription());
  }

  static ProjectDto toProjectDto(Project project) {
    return new ProjectDto(project.getId(), project.getKey(), project.getName(),
                          project.getDescription());
  }
}
