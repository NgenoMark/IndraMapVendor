package com.example.backend.api.model;

import lombok.Data;
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
@Table(name = "SURVEY_MATERIALS", schema = "SGC")
public class SurveyMaterial {
    @EmbeddedId
    private SurveyMaterialId id;


    @Column(name = "MAP_NUMBER")
    private String mapNumber;

    @Column(name = "APPLICATION_NUMBER")
    private String applicationNumber;

    @Column(name = "VENDOR_ID")
    private String vendorId;
@Column(name = "USUARIO")
    private String usuario;
@Column(name = "F_ACTUAL")
    private Date fActual;
@Column(name = "PROGRAMA")
    private String programa;
@Column(name = "MATERIAL")
    private String material;


    public String getMapNumber() {
        return mapNumber;
    }

    public void setMapNumber(String mapNumber) {
        this.mapNumber = mapNumber;
    }

    public String getApplicationNumber() {
        return applicationNumber;
    }

    public void setApplicationNumber(String applicationNumber) {
        this.applicationNumber = applicationNumber;
    }

    public String getVendorId() {
        return vendorId;
    }

    public void setVendorId(String vendorId) {
        this.vendorId = vendorId;
    }

    public SurveyMaterialId getId() {
        return id;
    }

    public void setId(SurveyMaterialId id) {
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


    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }
}