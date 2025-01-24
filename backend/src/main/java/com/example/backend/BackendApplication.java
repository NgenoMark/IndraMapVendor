package com.example.backend;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
//import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;

//@SpringBootApplication
@SpringBootApplication(scanBasePackages = "com.example.backend")
@EnableJpaRepositories(basePackages = "com.example.backend.api.repository")

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
            jdbcTemplate.execute("SELECT 1 FROM PBCATCOL");
            System.out.println("Connection successful");
        } catch (Exception e){
            System.err.println(e.getMessage());
        }
    }




}
