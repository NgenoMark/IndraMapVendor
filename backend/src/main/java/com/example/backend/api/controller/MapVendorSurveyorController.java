package com.example.backend.api.controller;


import com.example.backend.api.dto.MapVendorSurveyorRequest;
import com.example.backend.api.dto.MapVendorSurveyorResponse;
import com.example.backend.api.model.MapVendorSurveyor;
import com.example.backend.api.service.MapVendorSurveyorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityNotFoundException;
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

    @GetMapping("/searchSurveyor/{surveyorId}")
    public List<MapVendorSurveyorResponse> searchSurveyor(@PathVariable String surveyorId) {
        return mapVendorSurveyorService.findBySurveyorId(surveyorId);
    }

    @GetMapping("/selectSurveyor")
    public ResponseEntity<List<MapVendorSurveyorResponse>> getSurveyorsByVendor(
            @RequestParam String mapVendorId) {
        List<MapVendorSurveyorResponse> surveyors = mapVendorSurveyorService.findSurveyorByMapVendorId(mapVendorId);
        return ResponseEntity.ok(surveyors);
    }


    @PutMapping("/updateSurveyor")
    public MapVendorSurveyorResponse updateSurveyor(@RequestBody MapVendorSurveyorRequest request) throws Exception {
        return mapVendorSurveyorService.updateSurveyor(request);
    }

    @DeleteMapping("/deleteSurveyor/{surveyorId}/{employeeNumber}")
    public ResponseEntity<String> deleteSurveyor(
            @PathVariable String surveyorId,
            @PathVariable String employeeNumber) {
        try {
            // Call service method to delete surveyor
            mapVendorSurveyorService.deleteSurveyor(surveyorId, employeeNumber);
            return ResponseEntity.ok("Surveyor deleted successfully");
        } catch (EntityNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred: " + e.getMessage());
        }
    }





}
