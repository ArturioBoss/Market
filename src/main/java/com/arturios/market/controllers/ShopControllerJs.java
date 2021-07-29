package com.arturios.market.controllers;

import com.arturios.market.entites.Greeting;
import com.arturios.market.entites.Message;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class ShopControllerJs {
    @MessageMapping("/add_cart")
    @SendTo("/topic/greetings")
    public Greeting greeting(Message message) throws Exception {
        Thread.sleep(3000); // simulated delay
        return new Greeting(message.getName() + " добавлена в коризну!", message.getKey());
    }

}
