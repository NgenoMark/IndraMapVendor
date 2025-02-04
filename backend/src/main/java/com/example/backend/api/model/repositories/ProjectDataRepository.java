package com.example.backend.api.model.repositories;

import com.example.backend.api.model.ProjectData;
import com.example.backend.api.model.ProjectDataId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProjectDataRepository extends JpaRepository<ProjectData, ProjectDataId> {

//    Optional<ProjectData> findByProjectDataId_ApplicationNo(String applicationNo);
//
    Optional<ProjectData> findByProjectDataId_MapVendorId(String mapVendorId);

    Optional<ProjectData> findByProjectDataId_ApplicationNoOrProjectDataId_MapVendorId(String applicationNo , String mapVendorId);
}

