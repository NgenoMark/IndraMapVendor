package com.example.backend.api.service.impl;

import com.example.backend.api.dto.MapPaymentResponse;
import com.example.backend.api.dto.ProjectDataResponse;
import com.example.backend.api.exception.ResourceNotFoundException;
import com.example.backend.api.model.MapPayment;
import com.example.backend.api.model.ProjectData;
import com.example.backend.api.model.repositories.MapPaymentRepository;
import com.example.backend.api.service.MapPaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


@Service
public class MapPaymentImpl implements MapPaymentService {

    private MapPaymentRepository mapPaymentRepository;

    @Autowired
    public MapPaymentImpl(MapPaymentRepository mapPaymentRepository) {
        this.mapPaymentRepository = mapPaymentRepository;
    }

    @Override
    public List<MapPaymentResponse> getAllPayments() {
        return mapPaymentRepository.findAll().stream()
                .map(MapPaymentResponse::new)
                .collect(Collectors.toList());
    }

    @Override
    public List<MapPaymentResponse> getPaymentsByAccountIdOrIdRecord(String accountId, Long idRecord) {
        List<MapPayment> mapPaymentList = mapPaymentRepository
                .findByIdAccountIdOrIdIdRecord(accountId, idRecord)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "No payments found for ACCOUNT_ID: " + accountId + " or ID_RECORD: " + idRecord)
                );

        return mapPaymentList.stream()
                .map(MapPaymentResponse::new)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<List<MapPaymentResponse>> getPaymentByNumMap(String numMap) {
        Optional<List<MapPayment>> payments = mapPaymentRepository.findByNumMap(numMap);

        // Convert entity to response DTO
        return payments.map(list -> list.stream()
                .map(MapPaymentResponse::new)
                .collect(Collectors.toList()));
    }

    public MapPaymentResponse convertToResponse(MapPayment mapPayment) {
        return new MapPaymentResponse(mapPayment);
    }
}
