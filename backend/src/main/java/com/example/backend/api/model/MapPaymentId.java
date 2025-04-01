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
public class MapPaymentId implements Serializable {
    private static final long serialVersionUID = -9079040025988093700L;
    @Column(name = "ID_RECORD", columnDefinition = "unknown")
    private String idRecord;

    @Column(name = "ACCOUNT_ID", columnDefinition = "unknown")
    private String accountId;


    public String getIdRecord() {
        return idRecord;
    }

    public void setIdRecord(String idRecord) {
        this.idRecord = idRecord;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        MapPaymentId entity = (MapPaymentId) o;
        return Objects.equals(this.accountId, entity.accountId) &&
                Objects.equals(this.idRecord, entity.idRecord);
    }

    @Override
    public int hashCode() {
        return Objects.hash(accountId, idRecord);
    }

}