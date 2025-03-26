package com.example.backend.api.service;

import com.example.backend.api.dto.*;

import java.util.List;

public interface PaymentDetailsService {

    PaymentDetailResponse savePaymentDetails ( PaymentDetailRequest paymentDetailRequest);

    List<PaymentDetailResponse> getPaymentByApplicationNo(String applicationNo);

    List<PaymentDetailResponse> getAllPayments();

    PaymentDetailResponse findPaymentDetails(PaymentDetailRequest request);


}
