package com.example.backend.api.dto;

import com.example.backend.api.model.MapSurveyDetail;

import java.util.Date;

public class MapSurveyResponse {

    //private Long id;
    private String usuario;
    private Date fActual;
    private String programa;
    private Integer idSurveyData;
    private Integer idMapWs;
    private String numExp;
    private String mapNumber;
    private String tipFase;
    private String vendorId;

//    public Long getId() {
//        return id;
//    }
//
//    public void setId(Long id) {
//        this.id = id;
//    }

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

    public Integer getIdSurveyData() {
        return idSurveyData;
    }

    public void setIdSurveyData(Integer idSurveyData) {
        this.idSurveyData = idSurveyData;
    }

    public Integer getIdMapWs() {
        return idMapWs;
    }

    public void setIdMapWs(Integer idMapWs) {
        this.idMapWs = idMapWs;
    }

    public String getNumExp() {
        return numExp;
    }

    public void setNumExp(String numExp) {
        this.numExp = numExp;
    }

    public String getMapNumber() {
        return mapNumber;
    }

    public void setMapNumber(String mapNumber) {
        this.mapNumber = mapNumber;
    }

    public String getTipFase() {
        return tipFase;
    }

    public void setTipFase(String tipFase) {
        this.tipFase = tipFase;
    }

    public String getVendorId() {
        return vendorId;
    }

    public void setVendorId(String vendorId) {
        this.vendorId = vendorId;
    }

    public MapSurveyResponse( MapSurveyDetail mapSurveyDetail) {
        this.usuario = mapSurveyDetail.getUsuario();
        this.fActual = mapSurveyDetail.getfActual();
        this.programa = mapSurveyDetail.getPrograma();
        this.idSurveyData = mapSurveyDetail.getId().getIdSurveyData();
        this.idMapWs = mapSurveyDetail.getIdMapWs();
        this.numExp = mapSurveyDetail.getId().getNumExp();
        this.mapNumber = mapSurveyDetail.getId().getMapNumber();
        this.tipFase = mapSurveyDetail.getTipFase();
        this.vendorId = mapSurveyDetail.getVendorId();
    }
}
