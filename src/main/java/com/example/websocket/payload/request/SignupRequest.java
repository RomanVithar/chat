package com.example.websocket.payload.request;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.Set;


@Getter
@Setter
public class SignupRequest {
    @NotBlank
    @Size(max = 30)
    private String login;

    @NotBlank
    @Size(min = 6, max = 40)
    private String password;
}
