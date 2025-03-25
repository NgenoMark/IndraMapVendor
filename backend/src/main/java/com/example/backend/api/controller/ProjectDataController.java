package com.example.backend.api.controller;

import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.dto.ProjectDataResponse;
import com.example.backend.api.model.ProjectData;
import com.example.backend.api.service.ProjectDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.Optional;


@RestController
@RequestMapping("/project-data")
public class ProjectDataController {



    @Autowired
    private ProjectDataService projectDataService;



    @PostMapping(path = "/sendProjectData")
    public Object saveProjectData( @Valid @RequestBody ProjectDataRequest projectDataRequest)
    throws Exception {
        return projectDataService.saveProjectData( projectDataRequest);
    }

//    @GetMapping("/getProjectData/1.0.1/{applicationNoOrMapVendorId}")
//    public ResponseEntity<ProjectDataResponse> getProjectData(@PathVariable String applicationNoOrMapVendorId) {
//        ProjectDataResponse response = projectDataService.getProjectData(applicationNoOrMapVendorId);
//        return ResponseEntity.ok(response);
//    }

    @GetMapping("/getProjectData/1.0.1/{applicationNoOrMapNo}")
    public ResponseEntity<List<ProjectDataResponse>> getProjectData(@PathVariable String applicationNoOrMapNo) {
        List<ProjectDataResponse> response = projectDataService.getProjectData(applicationNoOrMapNo);
        return ResponseEntity.ok(response);
    }




//    // 🔹 Retrieve Data by Application Number (GET)
//    @GetMapping("/getProjectData/{applicationNo}")
//    public ResponseEntity<ProjectDataResponse> getProjectData(@PathVariable String applicationNo) {
//        ProjectDataResponse response = projectDataService.getProjectDataBy(applicationNo);
//        return ResponseEntity.ok(response);
//    }
//
//
//    @GetMapping("/getProjectById/{mapVendorId}")
//    public ResponseEntity<ProjectDataResponse> getProjectDataById(@PathVariable String mapVendorId) {
//        ProjectDataResponse response = projectDataService.getProjectDataById(mapVendorId);
//        return ResponseEntity.ok(response);
//    }

    @GetMapping("/getProjectById/{mapVendorId}")
    public ResponseEntity<List<ProjectDataResponse>> getProjectDataById(@PathVariable String mapVendorId) {
        List<ProjectDataResponse> response = projectDataService.getProjectDataById(mapVendorId);
        return ResponseEntity.ok(response);
    }


    // 🔹 Retrieve All Data (GET)
    @GetMapping("/getAllProjectData")
    public ResponseEntity<List<ProjectDataResponse>> getAllProjectData() {
        List<ProjectDataResponse> responseList = projectDataService.getAllProjectData();
        return ResponseEntity.ok(responseList);
    }

    @GetMapping("/status")
    public ResponseEntity<List<ProjectDataResponse>> getProjectDataStatus(
            @RequestParam(required = false) String completionStatus) {

        List<ProjectDataResponse> response;

        if (completionStatus == null || completionStatus.isEmpty()) {
            response = projectDataService.getAllProjectData();
        } else {
            response = projectDataService.getProjectDataByCompletionStatus(completionStatus);
        }

        return ResponseEntity.ok(response);
    }

    @PutMapping("/update")
    public ResponseEntity<Optional<ProjectDataResponse>> updateProject(@RequestBody ProjectDataRequest projectDataRequest) {
        Optional<ProjectDataResponse> updatedProject = projectDataService.updateProjectData(projectDataRequest);

        if (updatedProject.isPresent()) {
            return ResponseEntity.ok(updatedProject);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Optional.empty());
        }
    }


    @PatchMapping("/{applicationNo}/assign-surveyor")
    public ResponseEntity<String> assignSurveyor(
            @PathVariable String applicationNo,
            @RequestBody Map<String, String> request){

        String assignedToId = request.get("assignedToId");
        boolean updated = projectDataService.assignSurveyorToMap(applicationNo, assignedToId);

        if(updated){
            return ResponseEntity.ok("Surveyor assignment was successful");
        }else{
            return ResponseEntity.badRequest().body("Failed to assign surveyor.");
        }

    }


}
