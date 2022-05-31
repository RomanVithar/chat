package com.example.websocket.controler;

import com.example.websocket.dto.MessageDTO;
import com.example.websocket.repository.MessageRepository;
import com.example.websocket.service.MessageService;
import com.example.websocket.service.WsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WsController {
    private final WsService wsService;

    private final MessageService messageService;

    public WsController(WsService wsService, MessageService messageService) {
        this.wsService = wsService;
        this.messageService = messageService;
    }

    @PostMapping("/send-message")
    @CrossOrigin
    public void sendMessage(@RequestBody final MessageDTO messageDTO) {
        messageService.save(messageDTO);
        wsService.notifyFrontend(messageDTO.getMessageContent());
    }
}
