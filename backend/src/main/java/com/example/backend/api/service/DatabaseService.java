package com.example.backend.api.service;

import com.example.backend.BackendApplication;
import com.example.backend.api.controller.DatabaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class DatabaseService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> getAllTables() {
        String query = "SELECT TABLE_NAME FROM USER_TABLES"; // Fetch all table names
        return jdbcTemplate.queryForList(query);
    }

    public List<Map<String, Object>> getTableData(String tableName) {
        String query = "SELECT * FROM " + tableName;
        return jdbcTemplate.queryForList(query);
    }

}


