package com.arturios.market.services;

import com.arturios.market.entites.SystemUser;
import com.arturios.market.entites.User;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService {
    User findByUserName(String username);
    boolean save(SystemUser systemUser);
}
