package com.example.backend.api.service.impl;

import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.dto.ProjectDataResponse;
import com.example.backend.api.service.ProjectDataService;
import org.springframework.stereotype.Service;


@Service
public class ProjectDataServiceImpl implements ProjectDataService {

    @Override
    public ProjectDataResponse saveProjectData(ProjectDataRequest projectDataRequest)
            throws Exception
    {
        ProjectDataResponse projectDataResponse = new ProjectDataResponse();
        try {

        } catch (Exception e) {
            throw e;
        }
        return  projectDataResponse;

    }

}
