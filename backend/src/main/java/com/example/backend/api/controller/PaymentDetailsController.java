package com.example.backend.api.controller;

import com.example.backend.api.dto.PaymentDetailRequest;
import com.example.backend.api.dto.PaymentDetailResponse;
import com.example.backend.api.service.PaymentDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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


//    @GetMapping("/getPaymentByMapNo/{mapNo}")
//    public Object getPaymentByMapNo(@RequestParam String mapNo) {
//        return paymentDetailsService.getPaymentByMapNo(mapNo);
//    }

    @GetMapping("/getPaymentByMapNo/{mapNo}")
    public ResponseEntity<PaymentDetailResponse> getPaymentByMapNo(@PathVariable String mapNo){
        PaymentDetailResponse paymentDetailResponse = paymentDetailsService.getPaymentByMapNo(mapNo);
        return ResponseEntity.ok(paymentDetailResponse);
    }

}