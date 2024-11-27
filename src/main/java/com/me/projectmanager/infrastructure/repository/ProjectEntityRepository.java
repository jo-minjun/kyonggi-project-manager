package com.me.projectmanager.infrastructure.repository;

import com.me.projectmanager.infrastructure.entity.ProjectEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProjectEntityRepository extends JpaRepository<ProjectEntity, Long> {


}
