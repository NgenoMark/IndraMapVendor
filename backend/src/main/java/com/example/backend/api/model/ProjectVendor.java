package com.example.backend.api.model;

import javax.persistence.*;

@Entity
@Table(name = "project_vendors")
public class ProjectVendor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String companyName;

    @Column(nullable = false)
    private String companyAddress;

    @Column(nullable = false, unique = true)
    private String phoneNumber;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String contactPerson;

    @Column(nullable = false)
    private String contactPersonRole;

    @Column(nullable = false)
    private String projectCategories;

    @Column(nullable = false, unique = true)
    private String companyRegNumber;

    @Column(nullable = false, unique = true)
    private String taxId;

    @Column(nullable = false)
    private String password;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getCompanyAddress() { return companyAddress; }
    public void setCompanyAddress(String companyAddress) { this.companyAddress = companyAddress; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String contactPerson) { this.contactPerson = contactPerson; }

    public String getContactPersonRole() { return contactPersonRole; }
    public void setContactPersonRole(String contactPersonRole) { this.contactPersonRole = contactPersonRole; }

    public String getProjectCategories() { return projectCategories; }
    public void setProjectCategories(String projectCategories) { this.projectCategories = projectCategories; }

    public String getCompanyRegNumber() { return companyRegNumber; }
    public void setCompanyRegNumber(String companyRegNumber) { this.companyRegNumber = companyRegNumber; }

    public String getTaxId() { return taxId; }
    public void setTaxId(String taxId) { this.taxId = taxId; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
