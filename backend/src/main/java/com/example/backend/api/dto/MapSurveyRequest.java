package com.example.backend.api.dto;

import javax.persistence.Column;
import java.util.Date;

public class MapSurveyRequest {

    private String usuario;
    private Date fActual;
    private String programa;
    private Integer idSurveyData;
    private Integer idMapWs;
    private String numExp;
    private String mapNumber;
    private String tipFase;
    private String vendorId;

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
}
