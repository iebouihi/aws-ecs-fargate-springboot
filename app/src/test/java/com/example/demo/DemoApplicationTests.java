package com.example.demo;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DemoApplicationTests {

    @Autowired
    private HelloController controller;

    @Test
    void contextLoads() {
        assertThat(controller).isNotNull();
    }

    @Test
    void helloGreetsByName() {
        assertThat(controller.hello("ECS")).containsEntry("message", "Hello, ECS!");
    }

    @Test
    void infoContainsVersion() {
        assertThat(controller.info()).containsKeys("version", "hostname", "environment");
    }
}
