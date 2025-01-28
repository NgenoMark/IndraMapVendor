package com.example.backend.api.service;

import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.dto.ProjectDataResponse;

public interface  ProjectDataService {
    ProjectDataResponse saveProjectData (ProjectDataRequest projectDataRequest)
            throws Exception;
}
