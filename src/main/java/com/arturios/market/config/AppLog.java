package com.arturios.market.config;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import javax.persistence.Access;

@Aspect
@Component
public class AppLog {

    @Before("execution(public void com.arturios.market.services.ShoppingCartService.addToCart())")
    public void simlMetodBef(){
        System.out.println("Начало ");
    }

    @After("execution(public void com.arturios.market.services.ShoppingCartService.addToCart())")
    public void simlMetodAf(){
        System.out.println("Окончание ");
    }
}
