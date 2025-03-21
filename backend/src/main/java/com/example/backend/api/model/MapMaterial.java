package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Getter
@Setter
@Entity
@Table(name = "MAP_MATERIALS", schema = "SGC")
public class MapMaterial  implements Serializable {

    private static final long serialVersionUID = 1L; // Manually defined UID



    @Id
    @Column(name = "ID_MATERIALS", columnDefinition = "unknown")
    private Long idMaterials;


    @Column(name = "USUARIO")
    private String usuario;

    @Column(name = "F_ACTUAL")
    private String fActual;

    @Column(name = "PROGRAMA")
    private String programa;

    @Column(name = "ID_MAP_WS")
    private Long idMapWs;

    @Column(name = "NUM_EXP")
    private String numExp;

    @Column(name = "MAP_NUMBER")
    private String mapNumber;

    @Column(name = "MATERIAL")
    private String material;


    public Long getIdMaterials() {
        return idMaterials;
    }

    public void setIdMaterials(Long idMaterials) {
        this.idMaterials = idMaterials;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getfActual() {
        return fActual;
    }

    public void setfActual(String fActual) {
        this.fActual = fActual;
    }

    public String getPrograma() {
        return programa;
    }

    public void setPrograma(String programa) {
        this.programa = programa;
    }

    public Long getIdMapWs() {
        return idMapWs;
    }

    public void setIdMapWs(Long idMapWs) {
        this.idMapWs = idMapWs;
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

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }
}