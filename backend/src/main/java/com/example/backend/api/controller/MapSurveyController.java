package com.example.backend.api.controller;


import com.example.backend.api.dto.MapSurveyRequest;
import com.example.backend.api.dto.MapSurveyResponse;
import com.example.backend.api.service.MapSurveyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityNotFoundException;
import java.util.List;

@RestController
@RequestMapping("/survey")
public class MapSurveyController {


    private final MapSurveyService mapSurveyService;

    @Autowired
    public MapSurveyController(MapSurveyService mapSurveyService) {
        this.mapSurveyService = mapSurveyService;
    }


    @PostMapping("/saveSurvey")
    public ResponseEntity<MapSurveyResponse> saveMapSurvey(@RequestBody MapSurveyRequest request) throws Exception {
        MapSurveyResponse response = mapSurveyService.saveMapSurvey(request);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/fetchAllSurveys")
    public List<MapSurveyResponse> getAllSurveys() {
        return mapSurveyService.getAllSurveys();
    }

    @GetMapping("/searchSurvey/{mapNumber}")
    public List<MapSurveyResponse> findByMapNumber(@PathVariable("mapNumber") String mapNumber) {
        return mapSurveyService.findByMapNumber(mapNumber);
    }

    @PutMapping("/updateSurvey")
    public MapSurveyResponse updateMapSurvey(@RequestBody MapSurveyRequest request) throws Exception {
        return mapSurveyService.updateSurvey(request);
    }

    @DeleteMapping("/deleteSurvey/{idSurveyData}/{mapNumber}/{numExp}")
    public ResponseEntity<String> deleteSurvey(
            @PathVariable Integer idSurveyData,
            @PathVariable String mapNumber,
            @PathVariable String numExp) {
        try {
            // Call the service method to delete the survey
            mapSurveyService.deleteSurvey(idSurveyData, mapNumber, numExp);
            return ResponseEntity.ok("Survey deleted successfully");
        } catch (EntityNotFoundException e) {
            // Handle survey not found exception
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (Exception e) {
            // Handle other exceptions
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred: " + e.getMessage());
        }
    }


}
