package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class MapVendorSurveyorId implements Serializable {
    private static final long serialVersionUID = 8320475828942985482L;
    @Column(name = "SURVEYOR_ID", columnDefinition = "unknown")
    private String surveyorId;

    @Column(name = "EMPLOYEE_NUMBER", columnDefinition = "unknown")
    private String employeeNumber;


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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        MapVendorSurveyorId entity = (MapVendorSurveyorId) o;
        return Objects.equals(this.surveyorId, entity.surveyorId) &&
                Objects.equals(this.employeeNumber, entity.employeeNumber);
    }

    @Override
    public int hashCode() {
        return Objects.hash(surveyorId, employeeNumber);
    }

}