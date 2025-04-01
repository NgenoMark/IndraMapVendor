package com.example.backend.api.model.repositories;

import com.example.backend.api.model.ProjectStatus;
import com.example.backend.api.model.ProjectStatusId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProjectStatusRepository extends JpaRepository<ProjectStatus, ProjectStatusId> {


}
