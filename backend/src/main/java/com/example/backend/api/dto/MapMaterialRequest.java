package com.example.backend.api.dto;

public class MapMaterialRequest {


    private Long idMaterials;

    private String usuario;

    private String fActual;

    private String programa;

    private Long idMapWs;

    private String numExp;

    private String mapNumber;

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
