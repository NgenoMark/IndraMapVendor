package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Getter
@Setter
@Entity
@Table(name = "SURVEY_MATERIALS", schema = "SGC")
public class SurveyMaterial {
    @EmbeddedId
    private SurveyMaterialId id;

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
 TODO [Reverse Engineering] create field to map the 'MATERIAL_ID' column
 Available actions: Define target Java type | Uncomment as is | Remove column mapping
    @Column(name = "MATERIAL_ID", columnDefinition = "unknown")
    private Object materialId;
*/
/*
 TODO [Reverse Engineering] create field to map the 'MATERIAL' column
 Available actions: Define target Java type | Uncomment as is | Remove column mapping
    @Column(name = "MATERIAL", columnDefinition = "unknown")
    private Object material;
*/
}