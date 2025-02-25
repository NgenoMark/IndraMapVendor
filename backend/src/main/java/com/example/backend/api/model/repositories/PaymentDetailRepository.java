package com.example.backend.api.model.repositories;


import com.example.backend.api.dto.PaymentDetailResponse;
import com.example.backend.api.model.PaymentDetail;
import com.example.backend.api.model.PaymentDetailId;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.persistence.Embeddable;
import java.util.Optional;

@Embeddable

public interface PaymentDetailRepository extends JpaRepository<PaymentDetail, PaymentDetailId> {

   Optional<PaymentDetail> findById_MapNo(String mapNo);

}
