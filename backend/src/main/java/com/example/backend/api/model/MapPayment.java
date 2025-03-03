package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "MAP_PAYMENTS", schema = "SGC")
public class MapPayment {
    @EmbeddedId
    private MapPaymentId id;

@Column(name = "USUARIO", columnDefinition = "unknown")
    private String usuario;
@Column(name = "F_ACTUAL", columnDefinition = "unknown")
    private Date fActual;
@Column(name = "PROGRAMA", columnDefinition = "unknown")
    private String programa;
@Column(name = "NIS_RAD", columnDefinition = "unknown")
    private String nisRad;
@Column(name = "NUM_MAP", columnDefinition = "unknown")
    private String numMap;
@Column(name = "CO_MAP_VEND", columnDefinition = "unknown")
    private String coMapVend;
@Column(name = "IMP_TOT_REC", columnDefinition = "unknown")
    private Double impTotRec;
@Column(name = "IMP_PAGO", columnDefinition = "unknown")
    private Double impPago;
@Column(name = "IMP_QUOTA", columnDefinition = "unknown")
    private Double impQuota;
@Column(name = "REM_QUOTA", columnDefinition = "unknown")
    private Double remQuota;
@Column(name = "EST_PAGO", columnDefinition = "unknown")
    private String estPago;
@Column(name = "F_PAGO", columnDefinition = "unknown")
    private String fPago;
@Column(name = "F_VAL", columnDefinition = "unknown")
    private String fVal;
@Column(name = "F_TRANS", columnDefinition = "unknown")
    private String fTrans;
@Column(name = "REF_TRANS", columnDefinition = "unknown")
    private String refTrans;
@Column(name = "REF_PAGO", columnDefinition = "unknown")
    private String refPago;
@Column(name = "F_GEN", columnDefinition = "unknown")
    private String fGen;
@Column(name = "USER_GEN", columnDefinition = "unknown")
    private String  userGen;
@Column(name = "LINK_PAGO", columnDefinition = "unknown")
    private String linkPago;
@Column(name = "TIP_FORMA_PAGO", columnDefinition = "unknown")
    private String tipFormaPago;
@Column(name = "NUM_EXP", columnDefinition = "unknown")
    private String numExp;

    public MapPaymentId getId() {
        return id;
    }

    public void setId(MapPaymentId id) {
        this.id = id;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public Date getfActual() {
        return fActual;
    }

    public void setfActual(Date fActual) {
        this.fActual = fActual;
    }

    public String getPrograma() {
        return programa;
    }

    public void setPrograma(String programa) {
        this.programa = programa;
    }

    public String getNisRad() {
        return nisRad;
    }

    public void setNisRad(String nisRad) {
        this.nisRad = nisRad;
    }

    public String getNumMap() {
        return numMap;
    }

    public void setNumMap(String numMap) {
        this.numMap = numMap;
    }

    public String getCoMapVend() {
        return coMapVend;
    }

    public void setCoMapVend(String coMapVend) {
        this.coMapVend = coMapVend;
    }

    public Double getImpTotRec() {
        return impTotRec;
    }

    public void setImpTotRec(Double impTotRec) {
        this.impTotRec = impTotRec;
    }

    public Double getImpPago() {
        return impPago;
    }

    public void setImpPago(Double impPago) {
        this.impPago = impPago;
    }

    public Double getImpQuota() {
        return impQuota;
    }

    public void setImpQuota(Double impQuota) {
        this.impQuota = impQuota;
    }

    public Double getRemQuota() {
        return remQuota;
    }

    public void setRemQuota(Double remQuota) {
        this.remQuota = remQuota;
    }

    public String getEstPago() {
        return estPago;
    }

    public void setEstPago(String estPago) {
        this.estPago = estPago;
    }

    public String getfPago() {
        return fPago;
    }

    public void setfPago(String fPago) {
        this.fPago = fPago;
    }

    public String getfVal() {
        return fVal;
    }

    public void setfVal(String fVal) {
        this.fVal = fVal;
    }

    public String getfTrans() {
        return fTrans;
    }

    public void setfTrans(String fTrans) {
        this.fTrans = fTrans;
    }

    public String getRefTrans() {
        return refTrans;
    }

    public void setRefTrans(String refTrans) {
        this.refTrans = refTrans;
    }

    public String getRefPago() {
        return refPago;
    }

    public void setRefPago(String refPago) {
        this.refPago = refPago;
    }

    public String getfGen() {
        return fGen;
    }

    public void setfGen(String fGen) {
        this.fGen = fGen;
    }

    public String getUserGen() {
        return userGen;
    }

    public void setUserGen(String userGen) {
        this.userGen = userGen;
    }

    public String getLinkPago() {
        return linkPago;
    }

    public void setLinkPago(String linkPago) {
        this.linkPago = linkPago;
    }

    public String getTipFormaPago() {
        return tipFormaPago;
    }

    public void setTipFormaPago(String tipFormaPago) {
        this.tipFormaPago = tipFormaPago;
    }

    public String getNumExp() {
        return numExp;
    }

    public void setNumExp(String numExp) {
        this.numExp = numExp;
    }
}