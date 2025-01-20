package com.example.backend.api.controller;

import com.example.backend.service.DatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/database")
public class DatabaseController {

    @Autowired
    private DatabaseService databaseService;

    @GetMapping("/tables")
    public List<Map<String, Object>> getAllTables() {
        return databaseService.getAllTables();
    }

    @GetMapping("/table/{tableName}")
    public List<Map<String, Object>> getTableData(@PathVariable String tableName) {
        return databaseService.getTableData(tableName);
    }


}
