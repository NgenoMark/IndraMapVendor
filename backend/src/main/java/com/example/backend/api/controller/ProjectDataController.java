package com.example.backend.api.controller;

import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.dto.ProjectDataResponse;
import com.example.backend.api.model.ProjectData;
import com.example.backend.api.service.ProjectDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;


@RestController
@RequestMapping("/")
public class ProjectDataController {



    @Autowired
    private ProjectDataService projectDataService;



    @RequestMapping(path = "/sendProjectData")
    public Object saveProjectData( @Valid @RequestBody ProjectDataRequest projectDataRequest)
    throws Exception {
        return projectDataService.saveProjectData( projectDataRequest);
    }


    // 🔹 Retrieve Data by Application Number (GET)
    @GetMapping("/getProjectData/{applicationNo}")
    public ResponseEntity<ProjectDataResponse> getProjectData(@PathVariable String applicationNo) {
        ProjectDataResponse response = projectDataService.getProjectData(applicationNo);
        return ResponseEntity.ok(response);
    }

    // 🔹 Retrieve All Data (GET)
    @GetMapping("/getAllProjectData")
    public ResponseEntity<List<ProjectDataResponse>> getAllProjectData() {
        List<ProjectDataResponse> responseList = projectDataService.getAllProjectData();
        return ResponseEntity.ok(responseList);
    }

}
