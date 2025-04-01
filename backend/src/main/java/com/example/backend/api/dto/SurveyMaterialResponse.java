package com.example.backend.api.dto;

import com.example.backend.api.model.SurveyMaterial;

import java.util.Date;

public class SurveyMaterialResponse {

    private String usuario;
    private Date fActual;
    private String progarma;
    private Integer materialId;
    private String applicationNumber;
    private String mapNumber;
    private String vendorId;
    private String material;


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

    public String getProgarma() {
        return progarma;
    }

    public void setProgarma(String progarma) {
        this.progarma = progarma;
    }

    public Integer getMaterialId() {
        return materialId;
    }

    public void setMaterialId(Integer materialId) {
        this.materialId = materialId;
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

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public SurveyMaterialResponse(SurveyMaterial surveyMaterial) {
        this.usuario = surveyMaterial.getUsuario();
        this.fActual = surveyMaterial.getfActual();
        this.progarma = surveyMaterial.getPrograma();
        this.materialId = surveyMaterial.getId().getMaterialId();
        this.mapNumber = surveyMaterial.getMapNumber();
        this.vendorId = surveyMaterial.getVendorId();
        this.applicationNumber = surveyMaterial.getApplicationNumber();
        this.material = surveyMaterial.getMaterial();
    }
}
