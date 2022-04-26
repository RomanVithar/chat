package com.example.websocket.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import nonapi.io.github.classgraph.json.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.io.Serializable;

@Document(collection = "user")
@Data
@NoArgsConstructor
public class User implements Serializable {
    @Id
    private String id;
    private String login;
    private String password;
    private boolean active;
    private String roles;

    public User(String login, String password) {
        this.login = login;
        this.password = password;
        this.active = true;
        this.roles = "USER";
    }
}
