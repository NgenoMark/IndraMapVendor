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
@Table(name = "PROJECT_DATA", schema = "SGC")
public class ProjectData {


    @EmbeddedId
    private ProjectDataId projectDataId;
    

@Column(name = "USUARIO", columnDefinition = "unknown")
    private String usuario;
@Column(name = "F_ACTUAL", columnDefinition = "unknown")
    private Date fActual;
@Column(name = "PROGRAMA", columnDefinition = "unknown")
    private String programa;
@Column(name = "CUSTOMER_NAME", columnDefinition = "unknown")
    private String customerName;
@Column(name = "CUSTOMER_ADDRESS", columnDefinition = "unknown")
    private String customerAddress;
@Column(name = "CUSTOMER_TELEPHONE", columnDefinition = "unknown")
    private String customerTelephone;
@Column(name = "CITY", columnDefinition = "unknown")
    private String city;
@Column(name = "DISTRICT", columnDefinition = "unknown")
    private String district;
@Column(name = "ZONE", columnDefinition = "unknown")
    private String zone;

    public ProjectDataId getId() {
        return projectDataId;
    }

    public void setId(ProjectDataId id) {
        this.projectDataId = id;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public ProjectDataId getProjectDataId() {
        return projectDataId;
    }

    public void setProjectDataId(ProjectDataId projectDataId) {
        this.projectDataId = projectDataId;
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

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getCustomerTelephone() {
        return customerTelephone;
    }

    public void setCustomerTelephone(String customerTelephone) {
        this.customerTelephone = customerTelephone;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getZone() {
        return zone;
    }

    public void setZone(String zone) {
        this.zone = zone;
    }
}