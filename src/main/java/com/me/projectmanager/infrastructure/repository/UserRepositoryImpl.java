package com.me.projectmanager.infrastructure.repository;

import com.me.projectmanager.domain.User;
import com.me.projectmanager.domain.repository.UserRepository;
import com.me.projectmanager.infrastructure.mapper.UserEntityMapper;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class UserRepositoryImpl implements UserRepository {

  private final UserEntityRepository userEntityRepository;

  @Override
  public Optional<User> findByUsername(String username) {
    return userEntityRepository.findByUsername(username).map(UserEntityMapper::toUser);
  }

  @Override
  public User save(User user) {
    return UserEntityMapper.toUser(userEntityRepository.save(UserEntityMapper.toUserEntity(user)));
  }

  @Override
  public List<User> findAll() {
    return userEntityRepository.findAll().stream()
        .map(UserEntityMapper::toUser)
        .toList();
  }
}
