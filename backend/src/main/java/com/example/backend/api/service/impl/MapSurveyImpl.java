package com.example.backend.api.service.impl;

import com.example.backend.api.dto.MapSurveyRequest;
import com.example.backend.api.dto.MapSurveyResponse;
import com.example.backend.api.model.MapSurveyDetail;
import com.example.backend.api.model.MapSurveyDetailId;
import com.example.backend.api.model.repositories.MapSurveyRepository;
import com.example.backend.api.service.MapSurveyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

//    @Override
//    public MapSurveyResponse saveMapSurvey(MapSurveyRequest mapSurveyRequest) {
//
//        MapSurveyDetailId mapSurveyDetailId = new MapSurveyDetailId();
//
//        mapSurveyDetailId.setIdSurveyData( mapSurveyRequest.getIdSurveyData());
//        mapSurveyDetailId.setMapNumber( mapSurveyRequest.getMapNumber());
//        mapSurveyDetailId.setNumExp( mapSurveyRequest.getNumExp());
//
//        boolean exists = mapSurveyRepository.existsById( mapSurveyDetailId);
//        if (exists) {
//            MapSurveyResponse response = new MapSurveyResponse();
//            response.setIdSurveyData(mapSurveyRequest.getIdSurveyData());
//            response.setMapNumber(mapSurveyRequest.getMapNumber());
//            response.setNumExp(mapSurveyRequest.getNumExp());
//            response.setUsuario(mapSurveyRequest.getUsuario());
//            response.setfActual(mapSurveyRequest.getfActual());
//            response.setPrograma( mapSurveyRequest.getPrograma());
//            response.setIdMapWs(mapSurveyRequest.getIdMapWs());
//            response.setTipFase(mapSurveyRequest.getTipFase());
//            response.setVendorId(mapSurveyRequest.getVendorId());
//            return response;
//        }
//
//        MapSurveyDetail mapSurveyDetail = new MapSurveyDetail();
//        mapSurveyDetail.setId( mapSurveyDetailId);
//        //mapSurveyDetail.setUsuario( mapSurveyRequest.getUsuario());
//        //mapSurveyDetail.setfActual( mapSurveyRequest.getfActual());
//        mapSurveyDetail.setPrograma( mapSurveyRequest.getPrograma());
//        mapSurveyDetail.setIdMapWs( mapSurveyRequest.getIdMapWs());
//        mapSurveyDetail.setTipFase( mapSurveyRequest.getTipFase());
//        mapSurveyDetail.setVendorId( mapSurveyRequest.getVendorId());
//
//        mapSurveyDetail.setfActual( mapSurveyRequest.getfActual() != null ? mapSurveyRequest.getfActual() :new Date());
//        mapSurveyDetail.setUsuario( mapSurveyRequest.getUsuario() != null ? mapSurveyRequest.getUsuario() : "OPEN_U");
//
//
//        mapSurveyDetail = mapSurveyRepository.save(mapSurveyDetail);
//
//        return new MapSurveyResponse(mapSurveyDetail);
//
//    }

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
    public MapSurveyResponse updateProject( MapSurveyRequest mapSurveyRequest ) {
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




}
