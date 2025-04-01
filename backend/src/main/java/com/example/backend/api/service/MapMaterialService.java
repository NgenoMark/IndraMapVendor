package com.example.backend.api.service;

import com.example.backend.api.dto.MapMaterialResponse;

import java.util.List;
import java.util.Optional;

public interface  MapMaterialService {

    Optional<List<MapMaterialResponse>> findMaterialsByMapNumber(String mapNumber);
}
