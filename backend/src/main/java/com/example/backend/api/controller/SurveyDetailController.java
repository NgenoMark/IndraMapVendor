package com.example.backend.api.controller;


import com.example.backend.api.dto.PaymentDetailResponse;
import com.example.backend.api.dto.SurveyDetailRequest;
import com.example.backend.api.dto.SurveyDetailResponse;
import com.example.backend.api.model.SurveyDetail;
import com.example.backend.api.service.SurveyDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping( "/survey-detail")
public class SurveyDetailController {

    private final SurveyDetailService surveyDetailService;

    @Autowired
    public SurveyDetailController(SurveyDetailService surveyDetailService) {
        this.surveyDetailService = surveyDetailService;
    }

    @PostMapping("/saveSurveyDetail")
    public ResponseEntity<?> saveSurveyDetail(@RequestBody SurveyDetailRequest surveyDetailRequest) {
        try {
            SurveyDetailResponse response = surveyDetailService.saveSurveyDetail(surveyDetailRequest);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error saving survey details: " + e.getMessage());
        }
    }

    @GetMapping("/getByApplicationNo/{applicationNumber}")
    public List<SurveyDetailResponse> getSurveyDetailByApplicationNo(@PathVariable String applicationNumber){
        return surveyDetailService.getByApplicationNumber(applicationNumber);
    }


    @PostMapping("/sendSurvey/1.0.1/")
    public ResponseEntity<?> sendSurvey(@RequestBody SurveyDetailRequest request) {
        try {
            // Call service method with the full request object
            SurveyDetailResponse response = surveyDetailService.findSurveyDetails(request);

            if (response != null) {
                return ResponseEntity.ok(response);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Survey details not found for application number: " + request.getApplicationNumber());
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error retrieving survey details: " + e.getMessage());
        }
    }


    @PutMapping("/updateStatus/{surveyId}")
    public ResponseEntity<?> updateSurveyStatus(
            @PathVariable Integer surveyId,
            @RequestBody Map<String, String> request) {

        String newStatus = request.get("surveyStatus");
        if (newStatus == null || newStatus.isEmpty()) {
            return ResponseEntity.badRequest().body("Status is required");
        }

        try {
            boolean updated = surveyDetailService.updateSurveyStatus(surveyId, newStatus);
            if (updated) {
                List<SurveyDetailResponse> response = surveyDetailService.getSurveyById(surveyId);
                return ResponseEntity.ok(response);
            }
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body("Error updating status: " + e.getMessage());
        }
    }


//    @PutMapping("/updateStatus/{surveyId}")
//    public ResponseEntity<?> updateSurveyStatus(
//            @PathVariable String surveyId,
//            @RequestBody Map<String, String> request) {
//
//        try {
//            // Validate input
//            if (surveyId == null || surveyId.isEmpty()) {
//                return ResponseEntity.badRequest().body("Survey ID is required");
//            }
//
//            String newStatus = request.get("surveyStatus");
//            if (newStatus == null || newStatus.isEmpty()) {
//                return ResponseEntity.badRequest().body("Status is required");
//            }
//
//            // Update status
//            boolean updated = surveyDetailService.updateSurveyStatus(surveyId, newStatus);
//
//            if (updated) {
//                return ResponseEntity.ok(Map.of(
//                        "status", "success",
//                        "message", "Survey status updated",
//                        "surveyId", surveyId,
//                        "newStatus", newStatus
//                ));
//            }
//
//            return ResponseEntity.status(HttpStatus.NOT_FOUND)
//                    .body(Map.of(
//                            "status", "error",
//                            "message", "Survey not found"
//                    ));
//
//        } catch (NumberFormatException e) {
//            return ResponseEntity.badRequest().body(Map.of(
//                    "status", "error",
//                    "message", "Invalid survey ID format",
//                    "details", e.getMessage()
//            ));
//        } catch (Exception e) {
//            return ResponseEntity.internalServerError().body(Map.of(
//                    "status", "error",
//                    "message", "Failed to update status",
//                    "details", e.getMessage()
//            ));
//        }
//    }




}
