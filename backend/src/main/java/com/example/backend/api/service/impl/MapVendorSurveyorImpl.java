//package com.example.backend.api.service.impl;
//
//import com.example.backend.api.dto.MapVendorSurveyorRequest;
//import com.example.backend.api.dto.MapVendorSurveyorResponse;
//import com.example.backend.api.model.MapVendorSurveyor;
//import com.example.backend.api.model.MapVendorSurveyorId;
//import com.example.backend.api.model.repositories.MapSurveyRepository;
//import com.example.backend.api.model.repositories.MapVendorSurveyorRepository;
//import com.example.backend.api.service.MapVendorSurveyorService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//import java.util.stream.Collectors;
//
//@Service
//public class MapVendorSurveyorImpl implements MapVendorSurveyorService {
//
//
//    private final MapSurveyRepository mapSurveyRepository;
//    private MapVendorSurveyorRepository mapVendorSurveyorRepository;
//
//    @Autowired
//    private MapVendorSurveyorImpl(MapVendorSurveyorRepository mapVendorSurveyorRepository, MapSurveyRepository mapSurveyRepository) {
//        this.mapVendorSurveyorRepository = mapVendorSurveyorRepository;
//        this.mapSurveyRepository = mapSurveyRepository;
//    }
//
//    @Override
//    public List<MapVendorSurveyorResponse> getAllSurveyors(){
//        List<MapVendorSurveyor> MapVendorSurveyorList = mapVendorSurveyorRepository.findAll();
//        return MapVendorSurveyorList.stream().
//                map(MapVendorSurveyorResponse::new).
//                collect(Collectors.toList());
//
//    }
//
//    @Override
//    public MapVendorSurveyorResponse saveSurveyor(MapVendorSurveyorRequest mapVendorSurveyorRequest) {
//
//
//        MapVendorSurveyorId mapVendorSurveyorId = new MapVendorSurveyorId();
//        mapVendorSurveyorId.setSurveyorId(mapVendorSurveyorRequest.getSurveyorId());
//        mapVendorSurveyorId.setEmployeeNumber(mapVendorSurveyorRequest.getEmployeeNumber());
//
//        boolean exists = mapVendorSurveyorRepository.existsById(mapVendorSurveyorId);
//        if (exists) {
//            //return new MapVendorSurveyorResponse(mapVendorSurveyorRepository.findById(mapVendorSurveyorId).orElse(new MapVendorSurveyor()));
//            return new MapVendorSurveyorResponse(mapVendorSurveyorRepository.findById(mapVendorSurveyorId).orElse( null));
//        }
//
//        MapVendorSurveyor mapVendorSurveyor = new MapVendorSurveyor();
//        mapVendorSurveyor.setId(mapVendorSurveyorId);
//        mapVendorSurveyor.setUsuario(mapVendorSurveyorRequest.getUsuario());
//        mapVendorSurveyor.setfActual(mapVendorSurveyorRequest.getfActual());
//        mapVendorSurveyor.setPrograma( mapVendorSurveyorRequest.getPrograma());
//        mapVendorSurveyor.setMapVendorId(mapVendorSurveyorRequest.getMapVendorId());
//        mapVendorSurveyor.setMapNumber( mapVendorSurveyorRequest.getMapNumber());
//        mapVendorSurveyor.setName(mapVendorSurveyorRequest.getName());
//        mapVendorSurveyor.setEmail(mapVendorSurveyorRequest.getEmail());
//        mapVendorSurveyor.setPhoneNumber(mapVendorSurveyorRequest.getPhoneNumber());
//
//        mapVendorSurveyorDetail = mapSurveyRepository.save(mapVendorSurveyor)
//
//
//
//    }
//
//
//}


package com.example.backend.api.service.impl;

import com.example.backend.api.dto.MapVendorSurveyorRequest;
import com.example.backend.api.dto.MapVendorSurveyorResponse;
import com.example.backend.api.model.MapSurveyDetail;
import com.example.backend.api.model.MapVendorSurveyor;
import com.example.backend.api.model.MapVendorSurveyorId;
import com.example.backend.api.model.repositories.MapSurveyRepository;
import com.example.backend.api.model.repositories.MapVendorSurveyorRepository;
import com.example.backend.api.service.MapVendorSurveyorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class MapVendorSurveyorImpl implements MapVendorSurveyorService {

    private final MapSurveyRepository mapSurveyRepository;
    private final MapVendorSurveyorRepository mapVendorSurveyorRepository;

    @Autowired
    public MapVendorSurveyorImpl(MapVendorSurveyorRepository mapVendorSurveyorRepository, MapSurveyRepository mapSurveyRepository) {
        this.mapVendorSurveyorRepository = mapVendorSurveyorRepository;
        this.mapSurveyRepository = mapSurveyRepository;
    }

    @Override
    public List<MapVendorSurveyorResponse> getAllSurveyors() {
        List<MapVendorSurveyor> mapVendorSurveyorList = mapVendorSurveyorRepository.findAll();
        return mapVendorSurveyorList.stream()
                .map(MapVendorSurveyorResponse::new)
                .collect(Collectors.toList());
    }

    @Override
    public MapVendorSurveyorResponse saveSurveyor(MapVendorSurveyorRequest mapVendorSurveyorRequest) {
        // Create composite ID
        MapVendorSurveyorId mapVendorSurveyorId = new MapVendorSurveyorId();
        mapVendorSurveyorId.setSurveyorId(mapVendorSurveyorRequest.getSurveyorId());
        mapVendorSurveyorId.setEmployeeNumber(mapVendorSurveyorRequest.getEmployeeNumber());

        // Check if the entity already exists
        boolean exists = mapVendorSurveyorRepository.existsById(mapVendorSurveyorId);
        if (exists) {
            return mapVendorSurveyorRepository.findById(mapVendorSurveyorId)
                    .map(MapVendorSurveyorResponse::new)
                    .orElse(null);
        }

        // Create a new MapVendorSurveyor entity
        MapVendorSurveyor mapVendorSurveyor = new MapVendorSurveyor();
        mapVendorSurveyor.setId(mapVendorSurveyorId);
        //mapVendorSurveyor.setUsuario(mapVendorSurveyorRequest.getUsuario());
        //mapVendorSurveyor.setfActual(mapVendorSurveyorRequest.getfActual());
        mapVendorSurveyor.setPrograma(mapVendorSurveyorRequest.getPrograma());
        mapVendorSurveyor.setMapVendorId(mapVendorSurveyorRequest.getMapVendorId());
        mapVendorSurveyor.setMapNumber(mapVendorSurveyorRequest.getMapNumber());
        mapVendorSurveyor.setName(mapVendorSurveyorRequest.getName());
        mapVendorSurveyor.setEmail(mapVendorSurveyorRequest.getEmail());
        mapVendorSurveyor.setPhoneNumber(mapVendorSurveyorRequest.getPhoneNumber());


        mapVendorSurveyor.setfActual(mapVendorSurveyorRequest.getfActual() != null ? mapVendorSurveyorRequest.getfActual() : new Date());
        mapVendorSurveyor.setUsuario(mapVendorSurveyorRequest.getUsuario() != null ? mapVendorSurveyorRequest.getUsuario() : "DEFAULT_USER");


        // Save to repository
        mapVendorSurveyor = mapVendorSurveyorRepository.save(mapVendorSurveyor);

        // Return the saved entity as a response
        return new MapVendorSurveyorResponse(mapVendorSurveyor);
    }

    @Override
    public List<MapVendorSurveyorResponse> findBySurveyorId( String surveyorId) {
        return mapVendorSurveyorRepository.findByIdSurveyorId(surveyorId).
                stream().
                map(MapVendorSurveyorResponse::new)
                .collect(Collectors.toList());
    }

    @Override
    public MapVendorSurveyorResponse updateSurveyor(MapVendorSurveyorRequest mapVendorSurveyorRequest) {
        MapVendorSurveyorId mapVendorSurveyorId = new MapVendorSurveyorId();
        mapVendorSurveyorId.setSurveyorId(mapVendorSurveyorRequest.getSurveyorId());
        mapVendorSurveyorId.setEmployeeNumber(mapVendorSurveyorRequest.getEmployeeNumber());

//        boolean exists = mapVendorSurveyorRepository.existsById(mapVendorSurveyorId);
//        if (exists) {
//        }

        MapVendorSurveyor existingSurveyorDetail = mapVendorSurveyorRepository.findById(mapVendorSurveyorId).orElseThrow(()
                -> new RuntimeException("Surveyor not found"));

        existingSurveyorDetail.setPrograma(mapVendorSurveyorRequest.getPrograma());
        existingSurveyorDetail.setUsuario(mapVendorSurveyorRequest.getUsuario());
        existingSurveyorDetail.setMapVendorId(mapVendorSurveyorRequest.getMapVendorId());
        existingSurveyorDetail.setMapNumber(mapVendorSurveyorRequest.getMapNumber());
        existingSurveyorDetail.setName(mapVendorSurveyorRequest.getName());
        existingSurveyorDetail.setEmail(mapVendorSurveyorRequest.getEmail());
        existingSurveyorDetail.setPhoneNumber(mapVendorSurveyorRequest.getPhoneNumber());
        existingSurveyorDetail.setfActual(mapVendorSurveyorRequest.getfActual());

        existingSurveyorDetail = mapVendorSurveyorRepository.save(existingSurveyorDetail);

        return new MapVendorSurveyorResponse(existingSurveyorDetail);

    }

    @Override
    public void deleteSurveyor(String surveyorId , String employeeNumber) {
        MapVendorSurveyorId mapVendorSurveyorId = new MapVendorSurveyorId();
        mapVendorSurveyorId.setSurveyorId(surveyorId);
        mapVendorSurveyorId.setEmployeeNumber(employeeNumber);

        if(!mapVendorSurveyorRepository.existsById(mapVendorSurveyorId)) {
            //throw new RuntimeException("Surveyor not found");
            throw new EntityNotFoundException("Surveyor not found with ID: " + surveyorId + " and Employee Number: " + employeeNumber);

        }

        mapVendorSurveyorRepository.deleteById(mapVendorSurveyorId);
    }

}
