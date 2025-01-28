package com.example.backend.api.model.repositories;

import com.example.backend.api.model.ProjectData;
import org.springframework.data.repository.CrudRepository;

public interface ProjectDataRepository extends CrudRepository<ProjectData, Long> {
}
