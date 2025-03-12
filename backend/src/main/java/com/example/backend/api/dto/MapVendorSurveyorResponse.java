package com.example.backend.api.dto;

import com.example.backend.api.model.MapVendorSurveyor;

import java.util.Date;

public class MapVendorSurveyorResponse {

    private String surveyorId;
    private String employeeNumber;
    private String usuario;
    private Date fActual;
    private String programa;
    private String mapVendorId;
    private String mapNumber;
    private String name;
    private String email;
    private String phoneNumber;

    public String getSurveyorId() {
        return surveyorId;
    }

    public void setSurveyorId(String surveyorId) {
        this.surveyorId = surveyorId;
    }

    public String getEmployeeNumber() {
        return employeeNumber;
    }

    public void setEmployeeNumber(String employeeNumber) {
        this.employeeNumber = employeeNumber;
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

    public String getMapVendorId() {
        return mapVendorId;
    }

    public void setMapVendorId(String mapVendorId) {
        this.mapVendorId = mapVendorId;
    }

    public String getMapNumber() {
        return mapNumber;
    }

    public void setMapNumber(String mapNumber) {
        this.mapNumber = mapNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    // Constructor to convert entity to response DTO
    public MapVendorSurveyorResponse(MapVendorSurveyor surveyor) {
        this.surveyorId = surveyor.getId().getSurveyorId();
        this.employeeNumber = surveyor.getId().getEmployeeNumber();
        this.usuario = surveyor.getUsuario();
        this.fActual = surveyor.getfActual();
        this.programa = surveyor.getPrograma();
        this.mapVendorId = surveyor.getMapVendorId();
        this.mapNumber = surveyor.getMapNumber();
        this.name = surveyor.getName();
        this.email = surveyor.getEmail();
        this.phoneNumber = surveyor.getPhoneNumber();
    }
}
