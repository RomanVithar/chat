package com.example.websocket.payload.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResponseChatMessage extends ResponseMessage{
    private String receiver;

    public ResponseChatMessage(String content, String receiver) {
        super(content);
        this.receiver = receiver;
    }
}
