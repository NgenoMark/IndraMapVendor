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
public class MapSurveyDetailId implements Serializable {
    private static final long serialVersionUID = 1793680763020376085L;
    @Column(name = "ID_SURVEY_DATA")
    private Integer idSurveyData;

    @Column(name = "NUM_EXP", length  = 255)
    private String numExp;

    @Column(name = "MAP_NUMBER", length = 255)
    private String mapNumber;

    public Integer getIdSurveyData() {
        return idSurveyData;
    }

    public void setIdSurveyData(Integer idSurveyData) {
        this.idSurveyData = idSurveyData;
    }

    public String getNumExp() {
        return numExp;
    }

    public void setNumExp(String numExp) {
        this.numExp = numExp;
    }

    public String getMapNumber() {
        return mapNumber;
    }

    public void setMapNumber(String mapNumber) {
        this.mapNumber = mapNumber;
    }

//    public MapSurveyDetailId( Integer idSurveyData, String numExp, String mapNumber ) {
//        this.idSurveyData = idSurveyData;
//        this.numExp = numExp;
//        this.mapNumber = mapNumber;
//
//    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        MapSurveyDetailId entity = (MapSurveyDetailId) o;
        return Objects.equals(this.mapNumber, entity.mapNumber) &&
                Objects.equals(this.idSurveyData, entity.idSurveyData) &&
                Objects.equals(this.numExp, entity.numExp);
    }



    @Override
    public int hashCode() {
        return Objects.hash(mapNumber, idSurveyData, numExp);
    }

    // Override toString() to provide meaningful output
    @Override
    public String toString() {
        return "MapSurveyDetailId{" +
                "idSurveyData=" + idSurveyData +
                ", mapNumber='" + mapNumber + '\'' +
                ", numExp='" + numExp + '\'' +
                '}';
    }
}