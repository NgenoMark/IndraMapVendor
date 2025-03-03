package com.example.backend.api.service;

import com.example.backend.api.dto.MapPaymentResponse;
import com.example.backend.api.model.MapPaymentId;

import java.util.List;

public interface MapPaymentService {

    List<MapPaymentResponse> getAllPayments();

    //List<MapPaymentResponse> getPaymentsByAccountIdOrIdRecord( String accountId, String idRecord);

    List<MapPaymentResponse> getPaymentsByAccountIdOrIdRecord(String accountId, Long idRecord);


}
