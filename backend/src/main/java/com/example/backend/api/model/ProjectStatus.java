package com.example.backend.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "PROJECT_STATUS", schema = "SGC")
public class ProjectStatus implements Serializable {

    private static final long serialVersionUID = 1L;

    @EmbeddedId
    private ProjectStatusId id;

    @Column(name = "USUARIO", length = 100) // Assuming it's a string with a reasonable length
    private String usuario;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "F_ACTUAL", nullable = false)
    private Date fActual;

    @Column(name = "PROGRAMA", length = 100)
    private String programa;

    @Column(name = "MAP_VENDOR_ID", length = 50)
    private String mapVendorId;

    @Column(name = "COMPLETION_STATUS", length = 50)
    private String completionStatus;

    @Column(name = "SURVEY_STATUS", length = 50)
    private String surveyStatus;

    @Column(name = "ASSIGNED_TO_ID", length = 50)
    private String assignedToId;

    @Temporal(TemporalType.DATE)
    @Column(name = "START_DATE")
    private Date startDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "END_DATE")
    private Date endDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "LAST_UPDATED")
    private Date lastUpdated;

    @Column(name = "UPDATED_BY", length = 100)
    private String updatedBy;
}
