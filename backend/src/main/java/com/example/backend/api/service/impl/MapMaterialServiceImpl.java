package com.example.backend.api.service.impl;

import com.example.backend.api.dto.MapMaterialRequest;
import com.example.backend.api.dto.MapMaterialResponse;
import com.example.backend.api.dto.MapPaymentResponse;
import com.example.backend.api.model.MapMaterial;
import com.example.backend.api.model.repositories.MapMaterialRepository;
import com.example.backend.api.service.MapMaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


@Service
public class MapMaterialServiceImpl implements MapMaterialService {

    @Autowired
    private MapMaterialRepository mapMaterialRepository;

//    @Override
//    public Optional<List<MapMaterialResponse>> findMaterialsByMapNumber(String mapNumber) {
//        Optional<List<MapMaterial>> materials = mapMaterialRepository.findByMapNumber(mapNumber);
//
//        return materials.map(list -> list.stream()
//                .map(this::convertToResponse)
//                .collect(Collectors.toList()));
//    }

    @Override
    public Optional<List<MapMaterialResponse>> findMaterialsByMapNumber(String mapNumber) {
        Optional<List<MapMaterial>> materials = mapMaterialRepository.findByMapNumber(mapNumber);

        System.out.println("Fetching map materials for mapNumber: " + mapNumber);
        System.out.println("Materials Found: " + materials.isPresent());
        materials.ifPresent(list -> list.forEach(m -> System.out.println("Material: " + m.getMaterial())));

        return materials.map(list -> list.stream()
                .map(MapMaterialResponse::new)
                .collect(Collectors.toList()));
    }



    public MapMaterialResponse convertToResponse(MapMaterial mapMaterial) {
        return new  MapMaterialResponse(mapMaterial);

    }


}
