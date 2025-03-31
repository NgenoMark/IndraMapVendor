package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "SURVEY_DETAILS", schema = "SGC")
public class SurveyDetail {
    @EmbeddedId
    private SurveyDetailId id;

@Column(name = "USUARIO")
    private String usuario;
@Column(name = "F_ACTUAL")
    private Date fActual;
@Column(name = "PROGRAMA")
    private String programa;
@Column(name = "SURVEY_ID")
    private     Integer surveyId;
@Column(name = "METER_PHASE")
    private String meterPhase;
@Column(name = "SURVEY_STATUS")
    private String surveyStatus;

    public SurveyDetailId getId() {
        return id;
    }

    public void setId(SurveyDetailId id) {
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

    public Integer getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(Integer surveyId) {
        this.surveyId = surveyId;
    }

    public String getMeterPhase() {
        return meterPhase;
    }

    public void setMeterPhase(String meterPhase) {
        this.meterPhase = meterPhase;
    }

    public String getSurveyStatus() {
        return surveyStatus;
    }

    public void setSurveyStatus(String surveyStatus) {
        this.surveyStatus = surveyStatus;
    }
}


