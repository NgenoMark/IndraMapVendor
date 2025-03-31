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
public class SurveyDetailId implements Serializable {
    private static final long serialVersionUID = 987913956424763625L;
    @Column(name = "MAP_NUMBER")
    private String mapNumber;

    @Column(name = "APPLICATION_NUMBER")
    private String applicationNumber;

    @Column(name = "VENDOR_ID")
    private String vendorId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        SurveyDetailId entity = (SurveyDetailId) o;
        return Objects.equals(this.applicationNumber, entity.applicationNumber) &&
                Objects.equals(this.mapNumber, entity.mapNumber) &&
                Objects.equals(this.vendorId, entity.vendorId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(applicationNumber, mapNumber, vendorId);
    }


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
}