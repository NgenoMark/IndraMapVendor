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
public class SurveyMaterialId implements Serializable {
    private static final long serialVersionUID = 7803525232928693312L;
    @Column(name = "MAP_NUMBER", columnDefinition = "unknown")
    private Object mapNumber;

    @Column(name = "APPLICATION_NUMBER", columnDefinition = "unknown")
    private Object applicationNumber;

    @Column(name = "VENDOR_ID", columnDefinition = "unknown")
    private Object vendorId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        SurveyMaterialId entity = (SurveyMaterialId) o;
        return Objects.equals(this.applicationNumber, entity.applicationNumber) &&
                Objects.equals(this.mapNumber, entity.mapNumber) &&
                Objects.equals(this.vendorId, entity.vendorId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(applicationNumber, mapNumber, vendorId);
    }

}