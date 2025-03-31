package com.example.backend.api.service.impl;

import com.example.backend.api.dto.SurveyDetailRequest;
import com.example.backend.api.dto.SurveyDetailResponse;
import com.example.backend.api.model.PaymentDetail;
import com.example.backend.api.model.PaymentDetailId;
import com.example.backend.api.model.SurveyDetail;
import com.example.backend.api.model.repositories.PaymentDetailRepository;
import com.example.backend.api.dto.PaymentDetailRequest;
import com.example.backend.api.dto.PaymentDetailResponse;
import com.example.backend.api.service.PaymentDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PaymentDetailsServiceImpl implements PaymentDetailsService {

    private final PaymentDetailRepository paymentDetailRepository;

    @Autowired
    public PaymentDetailsServiceImpl(PaymentDetailRepository paymentDetailRepository) {
        this.paymentDetailRepository = paymentDetailRepository;
    }


    @Override
    public PaymentDetailResponse savePaymentDetails(PaymentDetailRequest paymentDetailRequest) {
        PaymentDetailId paymentDetailId = new PaymentDetailId();

        paymentDetailId.setApplicationNo(paymentDetailRequest.getApplicationNo());
        paymentDetailId.setMapNo(paymentDetailRequest.getMapNo());
        paymentDetailId.setMapVendorId(paymentDetailRequest.getMapVendorId());

        PaymentDetail paymentDetail = new PaymentDetail();
        paymentDetail.setId(paymentDetailId);
        paymentDetail.setPrograma(paymentDetailRequest.getPrograma());
        paymentDetail.setPaymentDate(paymentDetailRequest.getPaymentDate());
        paymentDetail.setPaymentRef(paymentDetailRequest.getPaymentRef());
        paymentDetail.setAmount(paymentDetailRequest.getAmount());


        paymentDetail.setUsuario(paymentDetailRequest.getUsuario() != null ? paymentDetailRequest.getUsuario() : "OPEN_U");
        paymentDetail.setfActual(paymentDetail.getfActual() != null ? paymentDetailRequest.getfActual() : new Date());


        paymentDetail = paymentDetailRepository.save(paymentDetail);

        return new PaymentDetailResponse(paymentDetail);

    }

    @Override
    public List<PaymentDetailResponse> getPaymentByApplicationNo(String applicationNo) {
        return paymentDetailRepository.findById_ApplicationNo(applicationNo)
                .stream()
                .map(PaymentDetailResponse::new)
                .collect(Collectors.toList());
    }

    @Override
    public List<PaymentDetailResponse> getAllPayments() {
        return paymentDetailRepository.findAll().stream()
                .map(PaymentDetailResponse::new)
                .collect(Collectors.toList());
    }


    @Override
    public PaymentDetailResponse findPaymentDetails(PaymentDetailRequest request) {
        // Fetch list, then get the first matching record
        PaymentDetail paymentDetail = paymentDetailRepository.findById_ApplicationNo(request.getApplicationNo())
                .stream()
                .findFirst()
                .orElse(null);

        if (paymentDetail != null) {
            return new PaymentDetailResponse(
                    paymentDetail.getId().getApplicationNo(),
                    paymentDetail.getId().getMapNo(),
                    paymentDetail.getId().getMapVendorId()
            );
        }

        return null; // Return null if not found
    }

}
