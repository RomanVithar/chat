package com.example.websocket;

import com.example.websocket.dto.Message;
import com.example.websocket.service.WsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WsController {

    @Autowired
    private WsService wsService;

    @PostMapping("/send-message")
    public void sendMessage(@RequestBody final Message message) {
        wsService.notifyFrontend(message.getMessageContent());
    }
}
