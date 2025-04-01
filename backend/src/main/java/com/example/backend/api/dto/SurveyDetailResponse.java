package com.example.backend.api.dto;

import com.example.backend.api.model.SurveyDetail;

import java.util.Date;

public class SurveyDetailResponse {

    private String usuario;
    private String programa;
    private Date fActual;
    private String applicationNumber;
    private String mapNumber;
    private String vendorId;
    private String meterPhase;
    private Integer surveyId;
    private String surveyStatus;

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getPrograma() {
        return programa;
    }

    public void setPrograma(String programa) {
        this.programa = programa;
    }

    public Date getfActual() {
        return fActual;
    }

    public void setfActual(Date fActual) {
        this.fActual = fActual;
    }

    public String getApplicationNumber() {
        return applicationNumber;
    }

    public void setApplicationNumber(String applicationNumber) {
        this.applicationNumber = applicationNumber;
    }

    public String getMapNumber() {
        return mapNumber;
    }

    public void setMapNumber(String mapNumber) {
        this.mapNumber = mapNumber;
    }

    public String getVendorId() {
        return vendorId;
    }

    public void setVendorId(String vendorId) {
        this.vendorId = vendorId;
    }

    public String getMeterPhase() {
        return meterPhase;
    }

    public void setMeterPhase(String meterPhase) {
        this.meterPhase = meterPhase;
    }

    public Integer getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(Integer surveyId) {
        this.surveyId = surveyId;
    }

    public String getSurveyStatus() {
        return surveyStatus;
    }

    public void setSurveyStatus(String surveyStatus) {
        this.surveyStatus = surveyStatus;
    }

    public SurveyDetailResponse(SurveyDetail surveyDetail) {
        this.programa = surveyDetail.getPrograma();
        this.usuario = surveyDetail.getUsuario();
        this.fActual = surveyDetail.getfActual();
        this.applicationNumber = surveyDetail.getId().getApplicationNumber();
        this.vendorId = surveyDetail.getId().getVendorId();
        this.mapNumber = surveyDetail.getId().getMapNumber();
        this.surveyId = surveyDetail.getSurveyId();
        this.meterPhase = surveyDetail.getMeterPhase();
        this.surveyStatus = surveyDetail.getSurveyStatus();
    }

    public SurveyDetailResponse(String applicationNumber, String mapNumber, String vendorId) {
        this.applicationNumber = applicationNumber;
        this.mapNumber = mapNumber;
        this.vendorId = vendorId;
    }


}
