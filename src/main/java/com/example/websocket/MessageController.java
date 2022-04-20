package com.example.websocket;

import com.example.websocket.dto.Message;
import com.example.websocket.dto.ResponseMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.HtmlUtils;

@Controller
public class MessageController {

    @MessageMapping("/message")
    @SendTo("/topic/messages")
    public ResponseMessage getMessage(final Message message) throws InterruptedException {
        System.out.println("message retrived");
        System.out.println(message.getMessageContent());
        return new ResponseMessage(HtmlUtils.htmlEscape(message.getMessageContent()));
    }
}
