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

    @Column(name = "MATERIAL_ID")
    private Integer materialId;


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        SurveyMaterialId entity = (SurveyMaterialId) o;
        return Objects.equals(this.materialId, entity.materialId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(materialId);
    }


    public Integer getMaterialId() {
        return materialId;
    }

    public void setMaterialId(Integer materialId) {
        this.materialId = materialId;
    }
}