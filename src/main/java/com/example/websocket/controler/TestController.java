package com.example.websocket.controler;


import com.example.websocket.service.MyUserDetailsService;
import com.example.websocket.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
public class TestController {
    @GetMapping("/test")
//    @PreAuthorize("hasRole('USER')")
    public String test() {
        System.out.println(
                SecurityContextHolder.getContext().getAuthentication().getName()
        );
        return ("test complete!");
    }
}
