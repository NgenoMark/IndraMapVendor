package com.example.backend.api.dto;


import com.example.backend.api.model.PaymentDetail;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;

@Getter
@Setter
public class PaymentDetailResponse {
    private String applicationNo;
    private String mapNo;
    private String mapVendorId;
    private String usuario;
    private Date fActual;
    private String programa;
    private BigDecimal amount;
    private Date paymentDate;
    private String paymentRef;


    public String getApplicationNo() {
        return applicationNo;
    }

    public void setApplicationNo(String applicationNo) {
        this.applicationNo = applicationNo;
    }

    public String getMapNo() {
        return mapNo;
    }

    public void setMapNo(String mapNo) {
        this.mapNo = mapNo;
    }

    public String getMapVendorId() {
        return mapVendorId;
    }

    public void setMapVendorId(String mapVendorId) {
        this.mapVendorId = mapVendorId;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public Date getfActual() {
        return fActual;
    }

    public void setfActual(Date fActual) {
        this.fActual = fActual;
    }

    public String getPrograma() {
        return programa;
    }

    public void setPrograma(String programa) {
        this.programa = programa;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentRef() {
        return paymentRef;
    }

    public void setPaymentRef(String paymentRef) {
        this.paymentRef = paymentRef;
    }

    public PaymentDetailResponse(PaymentDetail paymentDetail) {
        this.applicationNo = paymentDetail.getId().getApplicationNo();
        this.mapNo = paymentDetail.getId().getMapNo();
        this.mapVendorId = paymentDetail.getId().getMapVendorId();
        this.usuario = paymentDetail.getUsuario();
        this.fActual = paymentDetail.getfActual();
        this.programa = paymentDetail.getPrograma();
        this.amount = paymentDetail.getAmount();
        this.paymentDate = paymentDetail.getPaymentDate();
        this.paymentRef = paymentDetail.getPaymentRef();
    }


    public PaymentDetailResponse(String applicationNo , String mapNo, String mapVendorId) {
        this.applicationNo = applicationNo;
        this.mapNo = mapNo;
        this.mapVendorId = mapVendorId;
    }
}

