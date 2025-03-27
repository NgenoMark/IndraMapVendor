package com.example.backend.api.model.repositories;

import com.example.backend.api.model.SurveyDetail;
import com.example.backend.api.model.SurveyDetailId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface SurveyDetailRepository extends JpaRepository<SurveyDetail, SurveyDetailId> {

    List<SurveyDetail> findById_ApplicationNumber(String applicationNumber);

    @Query(nativeQuery = true, value = "SELECT SECUENCIAL(:seqName) FROM dual")
    Long getNextSeqValue(@Param("seqName") String seqName);


    // Custom method to update status
    @Modifying
    @Query("UPDATE SurveyDetail s SET s.surveyStatus = :surveyStatus WHERE s.surveyId = :surveyId")
    int updateSurveyStatus(@Param("surveyId") Integer surveyId,
                           @Param("surveyStatus") String surveyStatus);



//    @Modifying
//    @Query("UPDATE SurveyDetail s SET s.SURVEY_STATUS = :status WHERE s.surveyId = :surveyId")
//    int updateSurveyStatus(@Param("surveyId") Integer surveyId,
//                           @Param("status") String status);

    List<SurveyDetail> findBySurveyId(String surveyId);

}
