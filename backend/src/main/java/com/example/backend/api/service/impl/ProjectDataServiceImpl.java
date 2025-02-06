package com.example.backend.api.service.impl;

import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.dto.ProjectDataResponse;
import com.example.backend.api.model.ProjectData;
import com.example.backend.api.model.ProjectDataId;
import com.example.backend.api.model.repositories.ProjectDataRepository;
import com.example.backend.api.service.ProjectDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProjectDataServiceImpl implements ProjectDataService {

    @Autowired
    private ProjectDataRepository projectDataRepository;

    // 🔹 Save Project Data
    @Override
    public ProjectDataResponse saveProjectData(ProjectDataRequest projectDataRequest) {
        ProjectDataId projectDataId = new ProjectDataId();

        // Set composite key values
        projectDataId.setApplicationNo(projectDataRequest.getApplicationNo());
        projectDataId.setMapVendorId(projectDataRequest.getMapVendorId());
        projectDataId.setMapNo(projectDataRequest.getMapNo());

        // Check if data already exists
        boolean exists = projectDataRepository.existsById(projectDataId);
        if (exists) {
            ProjectDataResponse response = new ProjectDataResponse();
            response.setApplicationNo(projectDataRequest.getApplicationNo());
            response.setMapVendorId(projectDataRequest.getMapVendorId());
            response.setMapNo(projectDataRequest.getMapNo());
            response.setfActual(projectDataRequest.getfActual());
            response.setPrograma(projectDataRequest.getPrograma());
            response.setUsuario(projectDataRequest.getUsuario());
            response.setCustomerName(projectDataRequest.getCustomerName());
            response.setCustomerAddress(projectDataRequest.getCustomerAddress());
            response.setCustomerTelephone(projectDataRequest.getCustomerTelephone());
            response.setCity(projectDataRequest.getCity());
            response.setDistrict(projectDataRequest.getDistrict());
            response.setZone(projectDataRequest.getZone());
            response.setMessage("Data already exists");
            return response;
        }

        // Create new project data
        ProjectData projectData = new ProjectData();
        projectData.setProjectDataId(projectDataId);
        projectData.setPrograma(projectDataRequest.getPrograma());
        projectData.setCustomerName(projectDataRequest.getCustomerName());
        projectData.setCustomerAddress(projectDataRequest.getCustomerAddress());
        projectData.setCustomerTelephone(projectDataRequest.getCustomerTelephone());
        projectData.setCity(projectDataRequest.getCity());
        projectData.setDistrict(projectDataRequest.getDistrict());
        projectData.setZone(projectDataRequest.getZone());

        // Set factual and usuario fields with defaults if null
        projectData.setfActual(projectDataRequest.getfActual() != null ? projectDataRequest.getfActual() : new Date());
        projectData.setUsuario(projectDataRequest.getUsuario() != null ? projectDataRequest.getUsuario() : "DEFAULT_USER");

        // Save to database
        projectData = projectDataRepository.save(projectData);

        // Prepare response
        return convertToResponse(projectData, "Data saved successfully");
    }

    @Override
    public ProjectDataResponse getProjectData(String applicationNoOrMapVendorId) {
        ProjectData projectData = projectDataRepository.findByProjectDataId_ApplicationNoOrProjectDataId_MapVendorId(applicationNoOrMapVendorId ,applicationNoOrMapVendorId)
                .orElseThrow(() -> new RuntimeException("Project Data not found"));

        return convertToResponse(projectData, "Data retrieved successfully");
    }



    // 🔹 Retrieve Single Project Data by Application No
//    @Override
//    public ProjectDataResponse getProjectDataBy(String applicationNo) {
//        ProjectData projectData = projectDataRepository.findByProjectDataId_ApplicationNo(applicationNo)
//                .orElseThrow(() -> new RuntimeException("Project Data not found"));
//
//        return convertToResponse(projectData, "Data retrieved successfully");
//    }
//
//
//    @Override
//    public ProjectDataResponse getProjectDataById(String mapVendorId){
//        ProjectData projectData = projectDataRepository.findByProjectDataId_MapVendorId(mapVendorId)
//                .orElseThrow(() -> new RuntimeException("Project Data not found."));
//
//        return convertToResponse(projectData, "Data retrieved successfully");
//    }


    @Override
    public List<ProjectDataResponse> getProjectDataById(String mapVendorId) {
        List<ProjectData> projectDataList = projectDataRepository.findByProjectDataId_MapVendorId(mapVendorId);
        if (projectDataList.isEmpty()) {
            throw new RuntimeException("Project Data not found.");
        }
        return projectDataList.stream()
                .map(projectData -> convertToResponse(projectData, "Data retrieved successfully"))
                .collect(Collectors.toList());
    }


    // 🔹 Retrieve All Project Data
    @Override
    public List<ProjectDataResponse> getAllProjectData() {
        List<ProjectData> projectDataList = projectDataRepository.findAll();
        return projectDataList.stream()
                .map(data -> convertToResponse(data, "Data retrieved successfully"))
                .collect(Collectors.toList());
    }



    // 🔹 Convert Entity to Response DTO
    private ProjectDataResponse convertToResponse(ProjectData projectData, String message) {
        ProjectDataResponse response = new ProjectDataResponse();

        // Retrieve values from composite key
        ProjectDataId projectDataId = projectData.getProjectDataId();

        response.setApplicationNo(projectDataId.getApplicationNo());
        response.setMapVendorId(projectDataId.getMapVendorId());
        response.setMapNo(projectDataId.getMapNo());

        // Retrieve values from main entity
        response.setfActual(projectData.getfActual());
        response.setPrograma(projectData.getPrograma());
        response.setUsuario(projectData.getUsuario());
        response.setCustomerName(projectData.getCustomerName());
        response.setCustomerAddress(projectData.getCustomerAddress());
        response.setCustomerTelephone(projectData.getCustomerTelephone());
        response.setCity(projectData.getCity());
        response.setDistrict(projectData.getDistrict());
        response.setZone(projectData.getZone());
        response.setMessage(message);

        return response;
    }
}
