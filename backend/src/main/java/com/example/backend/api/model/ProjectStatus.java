package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.ObjectStreamClass;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "PROJECT_STATUS", schema = "SGC")
public class ProjectStatus {
    @EmbeddedId
    private ProjectStatusId id;

@Column(name = "USUARIO", columnDefinition = "unknown")
    private String usuario;
@Column(name = "F_ACTUAL", columnDefinition = "unknown")
    private Date fActual;
@Column(name = "PROGRAMA", columnDefinition = "unknown")
    private String   programa;
@Column(name = "MAP_VENDOR_ID", columnDefinition = "unknown")
    private String mapVendorId;
@Column(name = "COMPLETION_STATUS", columnDefinition = "unknown")
    private String completionStatus;
@Column(name = "SURVEY_STATUS", columnDefinition = "unknown")
    private String surveyStatus;
@Column(name = "ASSIGNED_TO_ID", columnDefinition = "unknown")
    private String assignedToId;
@Column(name = "START_DATE", columnDefinition = "unknown")
    private Date startDate;
@Column(name = "END_DATE", columnDefinition = "unknown")
    private Date endDate;
@Column(name = "LAST_UPDATED", columnDefinition = "unknown")
    private Date lastUpdated;
@Column(name = "UPDATED_BY", columnDefinition = "unknown")
    private String  updatedBy;

}