package com.example.websocket.controler;

import com.example.websocket.dto.MessageDTO;
import com.example.websocket.payload.response.ResponseMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.util.HtmlUtils;

@Controller
public class MessageController {

    @MessageMapping("/message")
    @SendTo("/topic/messages")
    @CrossOrigin
    public ResponseMessage getMessage(final MessageDTO message){
        return new ResponseMessage(HtmlUtils.htmlEscape(message.getMessageContent()));
    }
}
