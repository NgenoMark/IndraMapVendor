package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Getter
@Setter
@Entity
@Table(name = "PAYMENT_DETAILS", schema = "SGC")
public class PaymentDetail {
    @EmbeddedId
    private PaymentDetailId id;

@Column(name = "USUARIO", columnDefinition = "unknown")
    private Object usuario;
@Column(name = "F_ACTUAL", columnDefinition = "unknown")
    private Object fActual;
@Column(name = "PROGRAMA", columnDefinition = "unknown")
    private Object programa;
@Column(name = "AMOUNT", columnDefinition = "unknown")
    private Object amount;
@Column(name = "PAYMENT_DATE", columnDefinition = "unknown")
    private Object paymentDate;
@Column(name = "PAYMENT_REF", columnDefinition = "unknown")
    private Object paymentRef;

    public PaymentDetailId getId() {
        return id;
    }

    public void setId(PaymentDetailId id) {
        this.id = id;
    }

    public Object getUsuario() {
        return usuario;
    }

    public void setUsuario(Object usuario) {
        this.usuario = usuario;
    }

    public Object getfActual() {
        return fActual;
    }

    public void setfActual(Object fActual) {
        this.fActual = fActual;
    }

    public Object getPrograma() {
        return programa;
    }

    public void setPrograma(Object programa) {
        this.programa = programa;
    }

    public Object getAmount() {
        return amount;
    }

    public void setAmount(Object amount) {
        this.amount = amount;
    }

    public Object getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Object paymentDate) {
        this.paymentDate = paymentDate;
    }

    public Object getPaymentRef() {
        return paymentRef;
    }

    public void setPaymentRef(Object paymentRef) {
        this.paymentRef = paymentRef;
    }
}