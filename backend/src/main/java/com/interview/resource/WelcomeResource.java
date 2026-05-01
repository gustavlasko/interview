package com.interview.resource;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeResource {

    @RequestMapping("/api/welcome")
    public String index() {

        return "Welcome to the interview project!";
    }

    @GetMapping("/api/error")
    public String error() {
        throw new RuntimeException("This is a test exception!");
    }
}
