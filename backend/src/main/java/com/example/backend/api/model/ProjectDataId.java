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

public  class ProjectDataId implements Serializable {

    @Column(name = "APPLICATION_NO")
    private String applicationNo;
    @Column(name = "MAP_VENDOR_ID")
    private String mapVendorId;
    @Column(name = "MAP_NO")
    private String mapNo;
    private static final long serialVersionUID = 4531758268798428805L;

    public String getMapNo() {
        return mapNo;
    }

    public void setMapNo(String mapNo) {
        this.mapNo = mapNo;
    }

    public String getMapVendorId() {
        return mapVendorId;
    }

    public void setMapVendorId(String mapVendorId) {
        this.mapVendorId = mapVendorId;
    }

    public String getApplicationNo() {
        return applicationNo;
    }

    public void setApplicationNo(String applicationNo) {
        this.applicationNo = applicationNo;
    }



    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof ProjectDataId)) {
            return false;
        }
        ProjectDataId castOther = (ProjectDataId)other;
        return
                this.applicationNo.equals(castOther.applicationNo)
                        && this.mapVendorId.equals(castOther.mapVendorId)
                        && this.mapVendorId.equals(castOther.mapNo)
                ;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int hash = 17;
        hash = hash * prime + this.applicationNo.hashCode();
        hash = hash * prime + this.mapVendorId.hashCode();
        hash = hash * prime + this.mapVendorId.hashCode();

        return hash;
    }
}