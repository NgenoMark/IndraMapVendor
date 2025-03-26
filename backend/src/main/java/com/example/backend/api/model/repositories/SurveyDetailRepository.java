package com.example.backend.api.model.repositories;

import com.example.backend.api.model.SurveyDetail;
import com.example.backend.api.model.SurveyDetailId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface SurveyDetailRepository extends JpaRepository<SurveyDetail, SurveyDetailId> {

    List<SurveyDetail> findById_ApplicationNumber(String applicationNumber);

    @Query(nativeQuery = true, value = "SELECT SECUENCIAL(:seqName) FROM dual")
    Long getNextSeqValue(@Param("seqName") String seqName);

}
