package com.example.websocket.controler;

import com.example.websocket.entity.Message;
import com.example.websocket.service.MessageService;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/message")
public class MessageRestControllerV1 {

    private final MessageService messageService;

    public MessageRestControllerV1(MessageService messageService) {
        this.messageService = messageService;
    }

    @CrossOrigin
    @GetMapping
    public List<Message> messages() {
        return messageService.getAll();
    }
}
