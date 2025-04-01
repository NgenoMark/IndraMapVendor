package com.example.backend.api.model.repositories;

import com.example.backend.api.model.SurveyMaterial;
import com.example.backend.api.model.SurveyMaterialId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface SurveyMaterialRepository extends JpaRepository<SurveyMaterial, SurveyMaterialId> {

    List<SurveyMaterial> findByApplicationNumber(String applicationNumber);

    @Query(nativeQuery = true, value = "SELECT SECUENCIAL(:seqName) FROM dual")
    Long getNextSeqValue(@Param("seqName") String seqName);
}
