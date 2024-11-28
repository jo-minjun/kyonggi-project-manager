package com.me.projectmanager.application;

import com.me.projectmanager.domain.command.CreateUserCommand;
import com.me.projectmanager.domain.User;
import com.me.projectmanager.domain.repository.UserRepository;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

  private final UserRepository userRepository;

  public User findByUsername(String username) {
    return userRepository.findByUsername(username).get();
  }

  public User create(CreateUserCommand command) {
    Optional<User> userOptional = userRepository.findByUsername(command.getUsername());
    if (userOptional.isPresent()) {
      throw new RuntimeException("이미 존재하는 아이디입니다.");
    }

    User user = User.createFrom(command);

    return userRepository.save(user);
  }

  public User login(String username, String password) {
    User user = userRepository.findByUsername(username)
        .orElseThrow(() -> new RuntimeException("아이디 또는 패스워드가 일치하지 않습니다."));

    if (!user.getPassword().equals(password)) {
      throw new RuntimeException("아이디 또는 패스워드가 일치하지 않습니다.");
    }

    return user;
  }
}
