package com.example.backend.api.controller;


import com.example.backend.api.dto.MapSurveyRequest;
import com.example.backend.api.dto.MapSurveyResponse;
import com.example.backend.api.service.MapSurveyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/search/{mapNumber}")
    public List<MapSurveyResponse> findByMapNumber(@PathVariable("mapNumber") String mapNumber) {
        return mapSurveyService.findByMapNumber(mapNumber);
    }

    @PutMapping("/updateSurvey")
    public MapSurveyResponse updateMapSurvey(@RequestBody MapSurveyRequest request) throws Exception {
        return mapSurveyService.updateProject(request);
    }


}
