package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Getter
@Setter
@Entity
@Table(name = "SURVEY_DETAILS", schema = "SGC")
public class SurveyDetail {
    @EmbeddedId
    private SurveyDetailId id;

/*
 TODO [Reverse Engineering] create field to map the 'USUARIO' column
 Available actions: Define target Java type | Uncomment as is | Remove column mapping
    @Column(name = "USUARIO", columnDefinition = "unknown")
    private Object usuario;
*/
/*
 TODO [Reverse Engineering] create field to map the 'F_ACTUAL' column
 Available actions: Define target Java type | Uncomment as is | Remove column mapping
    @Column(name = "F_ACTUAL", columnDefinition = "unknown")
    private Object fActual;
*/
/*
 TODO [Reverse Engineering] create field to map the 'PROGRAMA' column
 Available actions: Define target Java type | Uncomment as is | Remove column mapping
    @Column(name = "PROGRAMA", columnDefinition = "unknown")
    private Object programa;
*/
/*
 TODO [Reverse Engineering] create field to map the 'SURVEY_ID' column
 Available actions: Define target Java type | Uncomment as is | Remove column mapping
    @Column(name = "SURVEY_ID", columnDefinition = "unknown")
    private Object surveyId;
*/
/*
 TODO [Reverse Engineering] create field to map the 'METER_PHASE' column
 Available actions: Define target Java type | Uncomment as is | Remove column mapping
    @Column(name = "METER_PHASE", columnDefinition = "unknown")
    private Object meterPhase;
*/
/*
 TODO [Reverse Engineering] create field to map the 'SURVEY_STATUS' column
 Available actions: Define target Java type | Uncomment as is | Remove column mapping
    @Column(name = "SURVEY_STATUS", columnDefinition = "unknown")
    private Object surveyStatus;
*/
}