package com.example.backend.api.controller;


import com.example.backend.api.dto.MapVendorSurveyorRequest;
import com.example.backend.api.dto.MapVendorSurveyorResponse;
import com.example.backend.api.model.MapVendorSurveyor;
import com.example.backend.api.service.MapVendorSurveyorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/surveyors")
public class MapVendorSurveyorController {

    private final MapVendorSurveyorService mapVendorSurveyorService;

    @Autowired
    public MapVendorSurveyorController(MapVendorSurveyorService mapVendorSurveyorService) {
        this.mapVendorSurveyorService = mapVendorSurveyorService;
    }

    @RequestMapping("/getAllSurveyors")
    public List<MapVendorSurveyorResponse> getAllSurveyors() {
        return mapVendorSurveyorService.getAllSurveyors();
    }

    @PostMapping("/saveSurveyor")
    public ResponseEntity<MapVendorSurveyorResponse> saveSurveyor(@RequestBody MapVendorSurveyorRequest request) throws Exception {
        MapVendorSurveyorResponse response = mapVendorSurveyorService.saveSurveyor(request);
        return ResponseEntity.ok(response);
    }

    @RequestMapping("/searchSurveyor/{surveyorId}")
    public List<MapVendorSurveyorResponse> searchSurveyor(@PathVariable String surveyorId) {
        return mapVendorSurveyorService.findBySurveyorId(surveyorId);
    }

}
