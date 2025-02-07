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
public class PaymentDetailId implements Serializable {
    private static final long serialVersionUID = -1331555916875501934L;
    @Column(name = "APPLICATION_NO", columnDefinition = "unknown")
    private Object applicationNo;

    @Column(name = "MAP_NO", columnDefinition = "unknown")
    private Object mapNo;

    @Column(name = "MAP_VENDOR_ID", columnDefinition = "unknown")
    private Object mapVendorId;

    public Object getApplicationNo() {
        return applicationNo;
    }

    public void setApplicationNo(Object applicationNo) {
        this.applicationNo = applicationNo;
    }

    public Object getMapNo() {
        return mapNo;
    }

    public void setMapNo(Object mapNo) {
        this.mapNo = mapNo;
    }

    public Object getMapVendorId() {
        return mapVendorId;
    }

    public void setMapVendorId(Object mapVendorId) {
        this.mapVendorId = mapVendorId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        PaymentDetailId entity = (PaymentDetailId) o;
        return Objects.equals(this.mapNo, entity.mapNo) &&
                Objects.equals(this.applicationNo, entity.applicationNo) &&
                Objects.equals(this.mapVendorId, entity.mapVendorId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(mapNo, applicationNo, mapVendorId);
    }

}