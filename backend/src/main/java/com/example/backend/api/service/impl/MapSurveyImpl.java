package com.example.backend.api.service.impl;

import com.example.backend.api.dto.MapSurveyRequest;
import com.example.backend.api.dto.MapSurveyResponse;
import com.example.backend.api.model.MapSurveyDetail;
import com.example.backend.api.model.MapSurveyDetailId;
import com.example.backend.api.model.repositories.MapSurveyRepository;
import com.example.backend.api.service.MapSurveyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;


@Service
public class MapSurveyImpl implements MapSurveyService {

    private MapSurveyRepository mapSurveyRepository;

    @Autowired
    public MapSurveyImpl(MapSurveyRepository mapSurveyRepository) {
        this.mapSurveyRepository = mapSurveyRepository;
    }

    @Override
    public MapSurveyResponse saveMapSurvey(MapSurveyRequest mapSurveyRequest) {

        // Create composite key
        MapSurveyDetailId mapSurveyDetailId = new MapSurveyDetailId();
        mapSurveyDetailId.setIdSurveyData(mapSurveyRequest.getIdSurveyData());
        mapSurveyDetailId.setMapNumber(mapSurveyRequest.getMapNumber());
        mapSurveyDetailId.setNumExp(mapSurveyRequest.getNumExp());

        // Check if entry already exists
        boolean exists = mapSurveyRepository.existsById(mapSurveyDetailId);
        if (exists) {
            return new MapSurveyResponse(mapSurveyRepository.findById(mapSurveyDetailId).orElse(null));
        }

        // Create new entity
        MapSurveyDetail mapSurveyDetail = new MapSurveyDetail();
        mapSurveyDetail.setId(mapSurveyDetailId);
        mapSurveyDetail.setPrograma(mapSurveyRequest.getPrograma());
        mapSurveyDetail.setIdMapWs(mapSurveyRequest.getIdMapWs());
        mapSurveyDetail.setTipFase(mapSurveyRequest.getTipFase());
        mapSurveyDetail.setVendorId(mapSurveyRequest.getVendorId());

        // Set default values for null fields
        mapSurveyDetail.setfActual(mapSurveyRequest.getfActual() != null ? mapSurveyRequest.getfActual() : new Date());
        mapSurveyDetail.setUsuario(mapSurveyRequest.getUsuario() != null ? mapSurveyRequest.getUsuario() : "DEFAULT_USER");

        // Save to database
        mapSurveyDetail = mapSurveyRepository.save(mapSurveyDetail);

        // Return response
        return new MapSurveyResponse(mapSurveyDetail);
    }


    @Override
    public List<MapSurveyResponse> getAllSurveys() {
        return mapSurveyRepository.findAll().stream()
                .map(MapSurveyResponse::new)
                .collect(Collectors.toList());
    }

    @Override
    public List<MapSurveyResponse> findByMapNumber(String mapNumber) {
        return mapSurveyRepository.findByIdMapNumber(mapNumber)
                .stream()
                .map(MapSurveyResponse::new)
                .collect(Collectors.toList());
    }

    @Override
    public MapSurveyResponse updateSurvey( MapSurveyRequest mapSurveyRequest ) {
        MapSurveyDetailId mapSurveyDetailId = new MapSurveyDetailId();
        mapSurveyDetailId.setIdSurveyData(mapSurveyRequest.getIdSurveyData());
        mapSurveyDetailId.setMapNumber(mapSurveyRequest.getMapNumber());
        mapSurveyDetailId.setNumExp(mapSurveyRequest.getNumExp());

        MapSurveyDetail existingSurveyDetail = mapSurveyRepository.findById(mapSurveyDetailId).orElseThrow(()
                -> new RuntimeException("Survey not found"));

        existingSurveyDetail.setUsuario(mapSurveyRequest.getUsuario());
        existingSurveyDetail.setPrograma(mapSurveyRequest.getPrograma());
        existingSurveyDetail.setIdMapWs(mapSurveyRequest.getIdMapWs());
        existingSurveyDetail.setTipFase(mapSurveyRequest.getTipFase());
        existingSurveyDetail.setVendorId(mapSurveyRequest.getVendorId());
        existingSurveyDetail.setVendorId(mapSurveyRequest.getVendorId());

        existingSurveyDetail = mapSurveyRepository.save(existingSurveyDetail);

        return new MapSurveyResponse(existingSurveyDetail);

    }

    @Override
    public void deleteSurvey(Integer idSurveyData, String mapNumber, String numExp) {
        // Create composite key and set its fields
        MapSurveyDetailId mapSurveyDetailId = new MapSurveyDetailId();
        mapSurveyDetailId.setIdSurveyData(idSurveyData);
        mapSurveyDetailId.setMapNumber(mapNumber);
        mapSurveyDetailId.setNumExp(numExp);

        // Check if the survey exists (optional, for custom error message)
        if (!mapSurveyRepository.existsById(mapSurveyDetailId)) {
            throw new EntityNotFoundException("Survey not found with ID: " + mapSurveyDetailId);
        }

        // Delete the survey
        mapSurveyRepository.deleteById(mapSurveyDetailId);
    }

}
