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
@Table(name = "MAP_VENDOR_SURVEYORS", schema = "SGC")
public class MapVendorSurveyor {
    @EmbeddedId
    private MapVendorSurveyorId id;

@Column(name = "USUARIO")
    private String usuario;
@Column(name = "F_ACTUAL")
    private Date fActual;
@Column(name = "PROGRAMA")
    private String programa;
@Column(name = "MAP_VENDOR_ID")
    private String mapVendorId;
@Column(name = "MAP_NUMBER")
    private String mapNumber;
@Column(name = "NAME")
    private String name;
@Column(name = "EMAIL")
    private String email;
@Column(name = "PHONE_NUMBER")
    private String phoneNumber;


    public MapVendorSurveyorId getId() {
        return id;
    }

    public void setId(MapVendorSurveyorId id) {
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
}