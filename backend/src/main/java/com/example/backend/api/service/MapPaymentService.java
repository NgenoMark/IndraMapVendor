package com.example.backend.api.service;

import com.example.backend.api.dto.MapPaymentResponse;
import com.example.backend.api.model.MapPaymentId;

import java.util.List;
import java.util.Optional;

public interface MapPaymentService {

    List<MapPaymentResponse> getAllPayments();

    List<MapPaymentResponse> getPaymentsByAccountIdOrIdRecord(String accountId, Long idRecord);

    Optional<List<MapPaymentResponse>> getPaymentByNumMap(String numMap);


}
