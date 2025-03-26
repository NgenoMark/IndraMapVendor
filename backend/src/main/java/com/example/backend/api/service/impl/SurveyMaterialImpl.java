package com.example.backend.api.service.impl;

import com.example.backend.api.dto.SurveyDetailResponse;
import com.example.backend.api.dto.SurveyMaterialRequest;
import com.example.backend.api.dto.SurveyMaterialResponse;
import com.example.backend.api.model.SurveyMaterial;
import com.example.backend.api.model.SurveyMaterialId;
import com.example.backend.api.model.repositories.SurveyMaterialRepository;
import com.example.backend.api.service.SurveyMaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SurveyMaterialImpl implements SurveyMaterialService {

    private final SurveyMaterialRepository  surveyMaterialRepository;

    @Autowired
    public SurveyMaterialImpl(SurveyMaterialRepository surveyMaterialRepository) {
        this.surveyMaterialRepository = surveyMaterialRepository;
    }

    @Override
    public SurveyMaterialResponse saveSurveyMaterial(SurveyMaterialRequest surveyMaterialRequest){

        SurveyMaterialId surveyMaterialId = new SurveyMaterialId();
        surveyMaterialId.setMaterialId(surveyMaterialRequest.getMaterialId());

//        boolean exists = surveyMaterialRepository.existsById(surveyMaterialId);
//        if(exists){
//            return new SurveyMaterialResponse(surveyMaterialRepository.findById(surveyMaterialId).orElse(null));
//        }

        SurveyMaterial surveyMaterial = new SurveyMaterial();
        surveyMaterial.setId(surveyMaterialId);
        surveyMaterial.setApplicationNumber(surveyMaterialRequest.getApplicationNumber());
        surveyMaterial.setVendorId(surveyMaterialRequest.getVendorId());
        surveyMaterial.setMapNumber(surveyMaterialRequest.getMapNumber());       surveyMaterial.setPrograma(surveyMaterialRequest.getPrograma());
        surveyMaterial.setMaterial(surveyMaterialRequest.getMaterial());

        surveyMaterial.setfActual(surveyMaterialRequest.getfActual() != null ? surveyMaterialRequest.getfActual() : new Date());
        surveyMaterial.setUsuario(surveyMaterialRequest.getUsuario() != null ? surveyMaterialRequest.getUsuario() : "DEFAULT_USER");

        surveyMaterial = surveyMaterialRepository.save(surveyMaterial);

        return new SurveyMaterialResponse(surveyMaterial);

    }

    @Override
    public List<SurveyMaterialResponse> getByApplicationNo(String applicationNumber){
        return surveyMaterialRepository.findByApplicationNumber(applicationNumber)
                .stream()
                .map(SurveyMaterialResponse::new)
                .collect(Collectors.toList());

    }

}
