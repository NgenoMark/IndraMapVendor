package com.example.backend.api.service;

import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.dto.ProjectDataResponse;

import java.util.List;
import java.util.Optional;

public interface  ProjectDataService {
    ProjectDataResponse saveProjectData (ProjectDataRequest projectDataRequest)
            throws Exception;

    //ProjectDataResponse getProjectData(String applicationNoOrMapVendorId);
    List<ProjectDataResponse> getProjectData(String applicationNoOrMapNo);

    //ProjectDataResponse getProjectDataBy(String applicationNumber);



    //ProjectDataResponse getProjectDataById(String mapVendorId);
    List<ProjectDataResponse> getProjectDataById(String mapVendorId);


    //ProjectDataResponse deleteProjectData(String applicationNumber);

    List<ProjectDataResponse> getAllProjectData();

    Optional<ProjectDataResponse> updateProjectData (ProjectDataRequest projectDataRequest);


    List<ProjectDataResponse> getProjectDataByCompletionStatus(String completionStatus);

}
