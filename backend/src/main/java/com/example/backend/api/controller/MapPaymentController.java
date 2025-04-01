package com.example.backend.api.controller;


import com.example.backend.api.dto.MapPaymentResponse;
import com.example.backend.api.service.MapPaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/payment")
public class MapPaymentController {

    private final MapPaymentService mapPaymentService;


    @Autowired
    public MapPaymentController(MapPaymentService mapPaymentService) {
        this.mapPaymentService = mapPaymentService;
    }

    // Fetch all payment details
    @GetMapping("/allPayments")
    public List<MapPaymentResponse> getAllPayments() {
        return mapPaymentService.getAllPayments();
    }

    // Fetch payment details by ACCOUNT_ID or ID_RECORD
    @GetMapping("/search")
    public List<MapPaymentResponse> getPaymentsByAccountIdOrIdRecord(
            @RequestParam(required = false) String accountId,
            @RequestParam(required = false) Long idRecord) {
        return mapPaymentService.getPaymentsByAccountIdOrIdRecord(accountId, idRecord);
    }

    @GetMapping("/numMap/{numMap}")
    public Optional<List<MapPaymentResponse>> getPaymentsByNumMap(@PathVariable String numMap) {
        Optional<List<MapPaymentResponse>> payments = mapPaymentService.getPaymentByNumMap(numMap);

        return mapPaymentService.getPaymentByNumMap(numMap);
    }



}
