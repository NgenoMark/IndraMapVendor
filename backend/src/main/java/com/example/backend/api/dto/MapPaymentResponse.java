package com.example.backend.api.dto;

import com.example.backend.api.model.MapPayment;
import com.example.backend.api.model.MapPaymentId;

import java.util.Date;

public class MapPaymentResponse {
    private String estPago;
    private String fPago;
    private String fVal;
    private String fTrans;
    private String refTrans;
    private String refPago;
    private String fGen;
    private String userGen;
    private String linkPago;
    private String tipFormaPago;
    private String numExp;
    private String usuario;
    private Date fActual;
    private String programa;
    private String idRecord;
    private String nisRad;
    private String accountId;
    private String numMap;
    private String coMapVend;
    private Double impTotRec;
    private Double impPago;
    private Double impQuota;
    private Double remQuota;

    public MapPaymentResponse(MapPaymentId id, String numMap, Double impTotRec, String estPago) {
    }

    public String getEstPago() {
        return estPago;
    }

    public void setEstPago(String estPago) {
        this.estPago = estPago;
    }

    public String getfPago() {
        return fPago;
    }

    public void setfPago(String fPago) {
        this.fPago = fPago;
    }

    public String getfVal() {
        return fVal;
    }

    public void setfVal(String fVal) {
        this.fVal = fVal;
    }

    public String getfTrans() {
        return fTrans;
    }

    public void setfTrans(String fTrans) {
        this.fTrans = fTrans;
    }

    public String getRefTrans() {
        return refTrans;
    }

    public void setRefTrans(String refTrans) {
        this.refTrans = refTrans;
    }

    public String getRefPago() {
        return refPago;
    }

    public void setRefPago(String refPago) {
        this.refPago = refPago;
    }

    public String getfGen() {
        return fGen;
    }

    public void setfGen(String fGen) {
        this.fGen = fGen;
    }

    public String getUserGen() {
        return userGen;
    }

    public void setUserGen(String userGen) {
        this.userGen = userGen;
    }

    public String getLinkPago() {
        return linkPago;
    }

    public void setLinkPago(String linkPago) {
        this.linkPago = linkPago;
    }

    public String getTipFormaPago() {
        return tipFormaPago;
    }

    public void setTipFormaPago(String tipFormaPago) {
        this.tipFormaPago = tipFormaPago;
    }

    public String getNumExp() {
        return numExp;
    }

    public void setNumExp(String numExp) {
        this.numExp = numExp;
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

    public String getIdRecord() {
        return idRecord;
    }

    public void setIdRecord(String idRecord) {
        this.idRecord = idRecord;
    }

    public String getNisRad() {
        return nisRad;
    }

    public void setNisRad(String nisRad) {
        this.nisRad = nisRad;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getNumMap() {
        return numMap;
    }

    public void setNumMap(String numMap) {
        this.numMap = numMap;
    }

    public String getCoMapVend() {
        return coMapVend;
    }

    public void setCoMapVend(String coMapVend) {
        this.coMapVend = coMapVend;
    }

    public Double getImpTotRec() {
        return impTotRec;
    }

    public void setImpTotRec(Double impTotRec) {
        this.impTotRec = impTotRec;
    }

    public Double getImpPago() {
        return impPago;
    }

    public void setImpPago(Double impPago) {
        this.impPago = impPago;
    }

    public Double getImpQuota() {
        return impQuota;
    }

    public void setImpQuota(Double impQuota) {
        this.impQuota = impQuota;
    }

    public Double getRemQuota() {
        return remQuota;
    }

    public void setRemQuota(Double remQuota) {
        this.remQuota = remQuota;
    }


    public MapPaymentResponse( MapPayment mapPayment ){

        this.usuario = mapPayment.getUsuario();
        this.fActual = mapPayment.getfActual();
        this.programa = mapPayment.getPrograma();
        this.idRecord = mapPayment.getId().getIdRecord();
        this.nisRad = mapPayment.getNisRad();
        this.accountId = mapPayment.getId().getAccountId();
        this.numMap = mapPayment.getNumMap();
        this.coMapVend = mapPayment.getCoMapVend();
        this.impTotRec = mapPayment.getImpTotRec();
        this.impPago = mapPayment.getImpPago();
        this.impQuota = mapPayment.getImpQuota();
        this.remQuota = mapPayment.getRemQuota();
        this.estPago = mapPayment.getEstPago();
        this.fPago = mapPayment.getfPago();
        this.fVal = mapPayment.getfVal();
        this.fTrans = mapPayment.getfTrans();
        this.refTrans = mapPayment.getRefTrans();
        this.refPago = mapPayment.getRefPago();
        this.fGen = mapPayment.getfGen();
        this.userGen = mapPayment.getUserGen();
        this.linkPago = mapPayment.getLinkPago();
        this.tipFormaPago = mapPayment.getTipFormaPago();
        this.numExp = mapPayment.getNumExp();
    }
}

