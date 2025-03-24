package com.example.backend.api.controller;


import com.example.backend.api.dto.MapMaterialResponse;
import com.example.backend.api.model.MapMaterial;
import com.example.backend.api.service.MapMaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/materials")
public class MapMaterialController {

    private final MapMaterialService mapMaterialService;

    @Autowired
    public MapMaterialController(MapMaterialService mapMaterialService) {
        this.mapMaterialService = mapMaterialService;
    }
//
//    @GetMapping("mapNo/{mapNumber}")
//    public Optional<List<MapMaterialResponse>> getMapNo(@PathVariable("mapNumber") String mapNumber) {
//        Optional<List<MapMaterialResponse>> materials = mapMaterialService.findMaterialsByMapNumber(mapNumber);
//
//        return mapMaterialService.findMaterialsByMapNumber(mapNumber);
//
//    }
@GetMapping("mapNo/{mapNumber}")
public ResponseEntity<List<MapMaterialResponse>> getMapNo(@PathVariable("mapNumber") String mapNumber) {
    Optional<List<MapMaterialResponse>> materials = mapMaterialService.findMaterialsByMapNumber(mapNumber);

    System.out.println("Materials Response: " + materials);

    return materials.map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
}


}
