package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "PAYMENT_DETAILS", schema = "SGC")
public class PaymentDetail {
    @EmbeddedId
    private PaymentDetailId id;

@Column(name = "USUARIO", columnDefinition = "unknown")
    private String usuario;

@Column(name = "F_ACTUAL", columnDefinition = "unknown")
    private Date fActual;

@Column(name = "PROGRAMA", columnDefinition = "unknown")
    private String  programa;

@Column(name = "AMOUNT", columnDefinition = "unknown")
    private BigDecimal amount;

@Column(name = "PAYMENT_DATE", columnDefinition = "unknown")
    private Date paymentDate;

@Column(name = "PAYMENT_REF", columnDefinition = "unknown")
    private String paymentRef;

    public PaymentDetailId getId() {
        return id;
    }

    public void setId(PaymentDetailId id) {
        this.id = id;
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
}