package com.example.backend.api.model.repositories;

import com.example.backend.api.dto.ProjectDataResponse;
import com.example.backend.api.model.ProjectData;
import com.example.backend.api.model.ProjectDataId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.awt.*;
import java.util.Optional;
import java.util.List;

@Repository
public interface ProjectDataRepository extends JpaRepository<ProjectData, ProjectDataId> {

//    Optional<ProjectData> findByProjectDataId_ApplicationNo(String applicationNo);


    //Optional<ProjectData> findByProjectDataId_ApplicationNoOrProjectDataId_MapVendorId(String applicationNo , String mapVendorId);
    //java.util.List<ProjectData> findByProjectDataId_ApplicationNoOrProjectDataId_MapVendorId(String applicationNo , String mapVendorId);


//    @Query("SELECT pd FROM ProjectData pd LEFT JOIN FETCH pd.paymentDetail WHERE pd.projectDataId.applicationNo = :applicationNo OR pd.projectDataId.mapNo = :mapNo")
//    java.util.List<ProjectData> findByProjectDataId_ApplicationNoOrProjectDataId_MapNo(@Param("applicationNo") String applicationNo, @Param("mapNo") String mapNo);

    java.util.List<ProjectData> findByProjectDataId_ApplicationNoOrProjectDataId_MapNo(@Param("applicationNo") String applicationNo, @Param("mapNo") String mapNo);



    //List<ProjectData> findByProjectDataId_MapVendorId(String mapVendorId);

    java.util.List<ProjectData> findByProjectDataId_MapVendorId(String mapVendorId);

    //Optional<ProjectData> findByProjectDataId_MapVendorId(String mapVendorId);

    java.util.List<ProjectData> findByCompletionStatus(String completionStatus);

    Optional<ProjectData> findByProjectDataId_MapNo(String mapNo);

}

