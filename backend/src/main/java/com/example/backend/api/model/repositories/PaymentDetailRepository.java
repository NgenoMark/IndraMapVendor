package com.example.backend.api.model.repositories;

import com.example.backend.api.model.PaymentDetail;
import com.example.backend.api.model.PaymentDetailId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaymentDetailRepository extends JpaRepository<PaymentDetail, PaymentDetailId> {


}
