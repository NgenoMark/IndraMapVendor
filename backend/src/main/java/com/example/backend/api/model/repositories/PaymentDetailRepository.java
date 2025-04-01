package com.example.backend.api.model.repositories;


import com.example.backend.api.dto.PaymentDetailResponse;
import com.example.backend.api.model.PaymentDetail;
import com.example.backend.api.model.PaymentDetailId;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.persistence.Embeddable;
import java.util.List;
import java.util.Optional;

@Embeddable

public interface PaymentDetailRepository extends JpaRepository<PaymentDetail, PaymentDetailId> {

   List<PaymentDetail> findById_ApplicationNo(String applicationNo);

}
