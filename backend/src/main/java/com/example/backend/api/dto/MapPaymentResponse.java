package com.example.backend.api.dto;

import com.example.backend.api.model.MapPayment;

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

    // Getters and Setters
    public String getEstPago() {
        return estPago;
    }

    public void setEstPago(String estPago) {
        this.estPago = estPago;
    }

    public String getFPago() {
        return fPago;
    }

    public void setFPago(String fPago) {
        this.fPago = fPago;
    }

    public String getFVal() {
        return fVal;
    }

    public void setFVal(String fVal) {
        this.fVal = fVal;
    }

    public String getFTrans() {
        return fTrans;
    }

    public void setFTrans(String fTrans) {
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

    public String getFGen() {
        return fGen;
    }

    public void setFGen(String fGen) {
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

    public Date getFActual() {
        return fActual;
    }

    public void setFActual(Date fActual) {
        this.fActual = fActual;
    }

    // (Other Getters and Setters are similar)

    public MapPaymentResponse( MapPayment mapPayment){
        this.idRecord = (String) mapPayment.getId().getIdRecord();
        this.accountId = (String) mapPayment.getId().getAccountId();
        this.fPago = (String) mapPayment.getfPago();
        this.estPago = (String ) mapPayment.getEstPago();
        this.fVal = (String) mapPayment.getfVal();
        this.fTrans = (String) mapPayment.getfTrans();
        this.fGen = (String) mapPayment.getfGen();
        this.userGen = (String) mapPayment.getUserGen();
        this.linkPago = (String) mapPayment.getLinkPago();
        this.tipFormaPago = (String) mapPayment.getTipFormaPago();
        this.numExp = (String) mapPayment.getNumExp();
        this.usuario = (String) mapPayment.getUsuario();
        this.fActual = (Date) mapPayment.getfActual();
        this.programa = (String) mapPayment.getPrograma();
        this.idRecord = (String) mapPayment.getId().getIdRecord();
        this.numMap = (String) mapPayment.getNumMap();
        this.coMapVend = (String) mapPayment.getCoMapVend();
        this.impTotRec = (Double) mapPayment.getImpTotRec();
        this.impPago = (Double) mapPayment.getImpPago();
        this.impQuota = (Double) mapPayment.getImpQuota();
        this.remQuota = (Double) mapPayment.getRemQuota();
        this.nisRad = (String) mapPayment.getNisRad();
        this.refTrans = (String) mapPayment.getRefTrans();
        this.refPago = (String) mapPayment.getRefPago();

    }
}

