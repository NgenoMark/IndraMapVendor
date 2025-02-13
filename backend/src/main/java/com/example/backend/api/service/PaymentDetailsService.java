package com.example.backend.api.service;

import com.example.backend.api.dto.PaymentDetailRequest;
import com.example.backend.api.dto.PaymentDetailResponse;
import com.example.backend.api.dto.ProjectDataRequest;
import com.example.backend.api.dto.ProjectDataResponse;

import java.util.List;

public interface PaymentDetailsService {

    PaymentDetailResponse savePaymentDetails ( PaymentDetailRequest paymentDetailRequest);
<<<<<<< HEAD
=======

    PaymentDetailResponse getPaymentByMapNo(String mapNo);
>>>>>>> be5aac4f9338c3257b2097a477aaec7b13faaca5
    List<PaymentDetailResponse> getAllPayments();

}
