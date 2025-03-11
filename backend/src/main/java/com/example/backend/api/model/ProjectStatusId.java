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
public class ProjectStatusId implements Serializable {
    private static final long serialVersionUID = -456703636840036304L;
    @Column(name = "PROJECT_ID", columnDefinition = "unknown")
    private String projectId;

    @Column(name = "MAP_NUMBER", columnDefinition = "unknown")
    private String mapNumber;

    @Column(name = "APPLICATION_NUMBER", columnDefinition = "unknown")
    private String applicationNumber;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        ProjectStatusId entity = (ProjectStatusId) o;
        return Objects.equals(this.applicationNumber, entity.applicationNumber) &&
                Objects.equals(this.mapNumber, entity.mapNumber) &&
                Objects.equals(this.projectId, entity.projectId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(applicationNumber, mapNumber, projectId);
    }

}