package com.teddie.backend.auth.presentation;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthController {

    @GetMapping("/auth/me")
    public ResponseEntity<String> getMe() {
        return ResponseEntity.ok("Hello, World!");
    }
}
