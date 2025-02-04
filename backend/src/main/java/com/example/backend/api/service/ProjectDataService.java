package com.example.backend.api.service;

import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.dto.ProjectDataResponse;

import java.util.List;

public interface  ProjectDataService {
    ProjectDataResponse saveProjectData (ProjectDataRequest projectDataRequest)
            throws Exception;

    ProjectDataResponse getProjectData(String applicationNoOrMapVendorId);

//    ProjectDataResponse getProjectDataBy(String applicationNumber);
//
    ProjectDataResponse getProjectDataById(String mapVendorId);

    //ProjectDataResponse deleteProjectData(String applicationNumber);

    List<ProjectDataResponse> getAllProjectData();
}
