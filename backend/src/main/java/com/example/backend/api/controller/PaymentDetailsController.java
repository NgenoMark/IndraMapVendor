package com.example.backend.api.controller;

import com.example.backend.api.dto.PaymentDetailRequest;
import com.example.backend.api.service.PaymentDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/")
public class PaymentDetailsController {

    private final PaymentDetailsService paymentDetailsService;

    @Autowired
    public PaymentDetailsController(PaymentDetailsService paymentDetailsService) {
        this.paymentDetailsService = paymentDetailsService;
    }

    @PostMapping("/sendPaymentDetails")
    public Object savePaymentDetails( @Valid @RequestBody PaymentDetailRequest paymentDetailRequest)
            throws Exception {
        return paymentDetailsService.savePaymentDetails( paymentDetailRequest);
    }

}