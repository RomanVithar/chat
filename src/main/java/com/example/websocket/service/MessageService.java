package com.example.websocket.service;

import com.example.websocket.dto.MessageDTO;
import com.example.websocket.entity.Message;
import com.example.websocket.entity.User;
import com.example.websocket.repository.MessageRepository;
import com.example.websocket.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class MessageService {
    private final MessageRepository messageRepository;
    private final UserRepository userRepository;

    public MessageService(MessageRepository messageRepository, UserRepository userRepository) {
        this.messageRepository = messageRepository;
        this.userRepository = userRepository;
    }

    public void save(MessageDTO messageDTO) {
        Message message = new Message();
        message.setContent(messageDTO.getMessageContent());
        User user = userRepository.findByLogin(SecurityContextHolder
                .getContext().getAuthentication().getName());
        message.setUser(user);
        messageRepository.save(message);
    }
}
