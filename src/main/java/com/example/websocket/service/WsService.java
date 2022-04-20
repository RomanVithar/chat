package com.example.websocket.service;

import com.example.websocket.dto.Message;
import com.example.websocket.dto.ResponseMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

@Service
public class WsService {
    private final SimpMessagingTemplate simpMessagingTemplate;

    @Autowired
    public WsService(SimpMessagingTemplate simpMessagingTemplate) {
        this.simpMessagingTemplate = simpMessagingTemplate;
    }

    public void notifyFrontend(final String message) {
        ResponseMessage responseMessage = new ResponseMessage(message);
        simpMessagingTemplate.convertAndSend("/topic/messages", responseMessage);
    }
}
