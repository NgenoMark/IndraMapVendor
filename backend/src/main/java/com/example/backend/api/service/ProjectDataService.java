package com.example.backend.api.service;

import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.dto.ProjectDataResponse;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

public interface  ProjectDataService {
    ProjectDataResponse saveProjectData (ProjectDataRequest projectDataRequest)
            throws Exception;

    List<ProjectDataResponse> getProjectData(String applicationNoOrMapNo);

    List<ProjectDataResponse> getProjectDataById(String mapVendorId);

    List<ProjectDataResponse> getAllProjectData();

    Optional<ProjectDataResponse> updateProjectData (ProjectDataRequest projectDataRequest);

    List<ProjectDataResponse> getProjectDataByCompletionStatus(String completionStatus);

    @Transactional
    boolean assignSurveyorToMap(String applicationNo, String assignedToId);

}
