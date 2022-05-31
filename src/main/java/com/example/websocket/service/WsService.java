package com.example.websocket.service;

import com.example.websocket.payload.response.ResponseChatMessage;
import com.example.websocket.payload.response.ResponseMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class WsService {
    private final SimpMessagingTemplate simpMessagingTemplate;

    @Autowired
    public WsService(SimpMessagingTemplate simpMessagingTemplate) {
        this.simpMessagingTemplate = simpMessagingTemplate;
    }

    public void notifyFrontend(final String message) {
        ResponseChatMessage responseMessage = new ResponseChatMessage(message, SecurityContextHolder
                .getContext().getAuthentication().getName());
        simpMessagingTemplate.convertAndSend("/topic/messages", responseMessage);
    }
}
