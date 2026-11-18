package com.example.demo;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    private final String appVersion;
    private final String environment;

    public HelloController(@Value("${app.version:local}") String appVersion,
                           @Value("${app.environment:local}") String environment) {
        this.appVersion = appVersion;
        this.environment = environment;
    }

    @GetMapping("/")
    public Map<String, String> root() {
        return Map.of("message", "Spring Boot on AWS ECS Fargate is running",
                      "endpoints", "/api/hello, /api/info, /actuator/health");
    }

    @GetMapping("/api/hello")
    public Map<String, String> hello(@RequestParam(defaultValue = "world") String name) {
        return Map.of("message", "Hello, " + name + "!");
    }

    /** Shows which Fargate task answered: refresh a few times to see the ALB spread load. */
    @GetMapping("/api/info")
    public Map<String, String> info() {
        Map<String, String> info = new LinkedHashMap<>();
        info.put("version", appVersion);
        info.put("environment", environment);
        info.put("hostname", hostname());
        info.put("javaVersion", System.getProperty("java.version"));
        info.put("timestamp", Instant.now().toString());
        return info;
    }

    private static String hostname() {
        try {
            return InetAddress.getLocalHost().getHostName();
        } catch (UnknownHostException e) {
            return "unknown";
        }
    }
}
