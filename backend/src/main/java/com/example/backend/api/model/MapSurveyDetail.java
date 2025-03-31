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
@Table(name = "MAP_SURVEY_DETAILS", schema = "SGC")
public class MapSurveyDetail {
    @EmbeddedId
    private MapSurveyDetailId id;

@Column(name = "USUARIO", length = 255)
    private String usuario;

@Column(name = "F_ACTUAL")
    private Date fActual;

@Column(name = "PROGRAMA", length = 255)
    private String programa;

@Column(name = "ID_MAP_WS")
    private Integer idMapWs;

@Column(name = "TIP_FASE", length = 255)
    private String tipFase;

@Column(name = "VENDOR_ID", length = 255)
    private String vendorId;

    public MapSurveyDetailId getId() {
        return id;
    }

    public void setId(MapSurveyDetailId id) {
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

    public Integer getIdMapWs() {
        return idMapWs;
    }

    public void setIdMapWs(Integer idMapWs) {
        this.idMapWs = idMapWs;
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