package com.me.projectmanager.domain.repository;

import com.me.projectmanager.domain.User;
import java.util.Optional;

public interface UserRepository {

  Optional<User> findByUsername(String username);

  User save(User user);
}
