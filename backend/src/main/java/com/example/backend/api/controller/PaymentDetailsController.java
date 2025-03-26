package com.example.backend.api.controller;

import com.example.backend.api.dto.PaymentDetailRequest;
import com.example.backend.api.dto.PaymentDetailResponse;
import com.example.backend.api.dto.SurveyDetailRequest;
import com.example.backend.api.dto.SurveyDetailResponse;
import com.example.backend.api.service.PaymentDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/payment-detail")
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

    @GetMapping("/getPaymentByApplicationNo/{applicationNo}")
    public List<PaymentDetailResponse> getPaymentByApplicationNo(@PathVariable String applicationNo){
        return paymentDetailsService.getPaymentByApplicationNo(applicationNo);
    }


    @PostMapping("/paymentConfirm")
    public ResponseEntity<?> sendPayment(@RequestBody PaymentDetailRequest request) {
        try {
            // Call service method with the full request object
            PaymentDetailResponse response = paymentDetailsService.findPaymentDetails(request);

            if (response != null) {
                return ResponseEntity.ok(response);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Survey details not found for application number: " + request.getApplicationNo());
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error retrieving survey details: " + e.getMessage());
        }
    }

}