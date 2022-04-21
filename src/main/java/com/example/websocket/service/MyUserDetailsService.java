package com.example.websocket.service;

import com.example.websocket.entity.MyUserDetails;
import com.example.websocket.entity.User;
import com.example.websocket.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
public class MyUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<User> user = Optional.ofNullable(userRepository.findByLogin(username));
        user.orElseThrow(() -> new UsernameNotFoundException("Not found " + username));
        return user.map(MyUserDetails::new).get();
    }
}
