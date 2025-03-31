package com.example.backend.api.model.repositories;

import com.example.backend.api.model.MapPayment;
import com.example.backend.api.model.MapPaymentId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MapPaymentRepository extends JpaRepository<MapPayment, MapPaymentId> {

    List<MapPayment> findAll();

    Optional<List<MapPayment>> findByIdAccountIdOrIdIdRecord(String accountId, Long idRecord);

    Optional<List<MapPayment>> findByNumMap(String numMap);

}
