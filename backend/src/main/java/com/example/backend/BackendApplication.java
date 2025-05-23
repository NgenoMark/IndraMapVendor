package com.example.backend;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootApplication
public class BackendApplication {

    @Autowired
    private JdbcTemplate jdbcTemplate;



    public static void main(String[] args) {

        ApplicationContext context = SpringApplication.run(BackendApplication.class, args);

        JdbcTemplate jdbcTemplate = context.getBean(JdbcTemplate.class);
        testDatabaseConnection(jdbcTemplate);
        //SpringApplication.run(BackendApplication.class, args);


    }

    private static void testDatabaseConnection(JdbcTemplate jdbcTemplate) {
        try {
            jdbcTemplate.execute("SELECT 1 FROM SUMCON");
            System.out.println("Connection successful");
        } catch (Exception e){
            System.err.println(e.getMessage());
        }
    }

}
