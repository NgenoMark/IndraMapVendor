package com.example.backend.api.controller;


import com.example.backend.api.dto.SurveyDetailRequest;
import com.example.backend.api.dto.SurveyDetailResponse;
import com.example.backend.api.dto.SurveyMaterialRequest;
import com.example.backend.api.dto.SurveyMaterialResponse;
import com.example.backend.api.service.SurveyDetailService;
import com.example.backend.api.service.SurveyMaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping( "/survey-material")
public class SurveyMaterialController {


    private final SurveyMaterialService surveyMaterialService;

    @Autowired
    public SurveyMaterialController(SurveyMaterialService surveyMaterialService) {
        this.surveyMaterialService = surveyMaterialService;
    }

    @PostMapping("/saveSurveyMaterial")
    public ResponseEntity<?> saveSurveyMaterial(@RequestBody SurveyMaterialRequest surveyMaterialRequest) {
        try {
            SurveyMaterialResponse response = surveyMaterialService.saveSurveyMaterial(surveyMaterialRequest);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error saving survey details: " + e.getMessage());
        }
    }

    @GetMapping("/getByApplicationNo/{applicationNumber}")
    public List<SurveyMaterialResponse> getSurveyMaterialByApplicationNo(@PathVariable String applicationNumber){
        return surveyMaterialService.getByApplicationNo(applicationNumber);
    }
}
