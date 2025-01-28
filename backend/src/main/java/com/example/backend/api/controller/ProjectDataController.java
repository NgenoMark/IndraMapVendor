package com.example.backend.api.controller;

import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.model.ProjectData;
import com.example.backend.api.service.ProjectDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;


@RestController("/")
public class ProjectDataController {



    @Autowired
    private ProjectDataService projectDataService;



    @RequestMapping(path = "sendProjectData/")
    public Object saveProjectData( @Valid @RequestBody ProjectDataRequest projectDataRequest)
    throws Exception {
        return projectDataService.saveProjectData( projectDataRequest);
    }




}
