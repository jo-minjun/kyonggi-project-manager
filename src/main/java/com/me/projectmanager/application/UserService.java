package com.me.projectmanager.application;

import com.me.projectmanager.domain.User;
import com.me.projectmanager.domain.command.CreateUserCommand;
import com.me.projectmanager.domain.repository.UserRepository;
import java.io.File;
import java.io.IOException;
import java.util.Optional;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class UserService {

  private final UserRepository userRepository;

  @Transactional(readOnly = true)
  public User findByUsername(String username) {
    return userRepository.findByUsername(username).get();
  }

  @Transactional
  public User create(CreateUserCommand command) {
    Optional<User> userOptional = userRepository.findByUsername(command.getUsername());
    if (userOptional.isPresent()) {
      throw new RuntimeException("이미 존재하는 아이디입니다.");
    }

    User user = User.createFrom(command);

    return userRepository.save(user);
  }

  @Transactional(readOnly = true)
  public User login(String username, String password) {
    User user = userRepository.findByUsername(username)
        .orElseThrow(() -> new RuntimeException("아이디 또는 패스워드가 일치하지 않습니다."));

    if (!user.getPassword().equals(password)) {
      throw new RuntimeException("아이디 또는 패스워드가 일치하지 않습니다.");
    }

    return user;
  }

  @Transactional
  public User updateProfile(String username, String name, String password,
                            MultipartFile profilePicture) throws IOException {
    // 로그인한 사용자 프로필 가져오기
    User user = findByUsername(username);

    // 이름 업데이트
    user.setName(name);
    user.setPassword(password);

    // 프로필 사진 업데이트
    if (profilePicture != null && !profilePicture.isEmpty()) {
      String savedPath = saveProfilePicture(profilePicture);
      user.setProfile(savedPath); // 저장된 경로를 사용자 프로필에 설정
    }

    return userRepository.save(user);
  }

  private String saveProfilePicture(MultipartFile file) throws IOException {
    String uploadDirPath = new File("src/main/webapp/resources/image/upload").getAbsolutePath();
    File uploadDir = new File(uploadDirPath);
    if (!uploadDir.exists()) {
      uploadDir.mkdirs();
    }

    String suffix = file.getName().contains("png") ? ".png" : ".jpg";

    String fileName = UUID.randomUUID() + suffix;

    File newFile = new File(uploadDir, fileName);
    file.transferTo(newFile);

    return "/resources/image/upload/" + newFile.getName();
  }

}
