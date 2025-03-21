package com.example.backend.api.controller;


import com.example.backend.api.model.MapMaterial;
import com.example.backend.api.service.MapMaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/materials")
public class MapMaterialController {

    private final MapMaterialService mapMaterialService;

    @Autowired
    public MapMaterialController(MapMaterialService mapMaterialService) {
        this.mapMaterialService = mapMaterialService;
    }

    @GetMapping("mapNo/{mapNumber}")
    public MapMaterial getMapNo(@PathVariable("mapNumber") Long mapNumber) {

    }
}
