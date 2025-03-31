package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "PROJECT_DATA", schema = "SGC")
public class ProjectData {

    @EmbeddedId
    private ProjectDataId projectDataId;

@Column(name = "USUARIO")
    private String usuario;
@Column(name = "F_ACTUAL")
    private Date fActual;
@Column(name = "PROGRAMA")
    private String programa;
@Column(name = "CUSTOMER_NAME")
    private String customerName;
@Column(name = "CUSTOMER_ADDRESS")
    private String customerAddress;
@Column(name = "CUSTOMER_TELEPHONE")
    private String customerTelephone;
@Column(name = "CITY")
    private String city;
@Column(name = "DISTRICT")
    private String district;
@Column(name = "ZONE")
    private String zone;

@Column(name = "COMPLETION_STATUS")
    private String completionStatus;

@Column(name = "SURVEY_STATUS")
    private String surveyStatus;

@Column(name = "ASSIGNED_TO_ID")
    private String assignedToId;

@Column(name = "START_DATE")
    private Date startDate;

@Column(name = "END_DATE")
    private Date endDate;

@Column(name = "LAST_UPDATED")
    private Date lastUpdated;

@Column(name = "UPDATED_BY")
    private String updatedBy;

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

    public String getCompletionStatus() {
        return completionStatus;
    }

    public void setCompletionStatus(String completionStatus) {
        this.completionStatus = completionStatus;
    }

    public String getSurveyStatus() {
        return surveyStatus;
    }

    public void setSurveyStatus(String surveyStatus) {
        this.surveyStatus = surveyStatus;
    }

    public String getAssignedToId() {
        return assignedToId;
    }

    public void setAssignedToId(String assignedToId) {
        this.assignedToId = assignedToId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }
}