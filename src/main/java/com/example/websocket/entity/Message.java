package com.example.websocket.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document
@Data
public class Message {
    @Id
    private String id;

    @Field
    @DBRef
    private User user;

    @Field
    private String content;
}
