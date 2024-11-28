<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Settings</title>
    <style>
      body {
        background-color: #f4f5f7;
        font-family: Arial, sans-serif;
      }

      .container {
        margin-top: 50px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 20px;
        max-width: 800px;
        margin-left: auto;
        margin-right: auto;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-label {
        font-weight: bold;
        color: #5E6C84;
        display: block;
        margin-bottom: 5px;
      }

      .form-input {
        width: 100%;
        padding: 10px;
        font-size: 1rem;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #f4f5f7;
      }

      .form-input:focus {
        outline: none;
        border-color: #0052CC;
        background-color: #fff;
      }

      .form-error {
        font-size: 0.85rem;
        color: #DC3545;
        margin-top: 5px;
      }

      .profile-pic-container {
        display: flex;
        align-items: center;
        gap: 20px;
      }

      .profile-pic {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        border: 2px solid #ccc;
        object-fit: cover;
      }

      .profile-pic:hover {
        border-color: #0052CC;
      }

      .upload-btn {
        display: inline-block;
        padding: 10px 15px;
        font-size: 1rem;
        color: white;
        background-color: #0052CC;
        border: none;
        border-radius: 4px;
        cursor: pointer;
      }

      .upload-btn:hover {
        background-color: #0041a8;
      }

      .save-btn {
        display: inline-block;
        padding: 10px 20px;
        font-size: 1rem;
        font-weight: bold;
        color: white;
        background-color: #36B37E;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 20px;
      }

      .save-btn:hover {
        background-color: #2c9c69;
      }

      .cancel-btn {
        display: inline-block;
        padding: 10px 20px;
        font-size: 1rem;
        font-weight: bold;
        color: #5E6C84;
        background-color: #f4f5f7;
        border: 1px solid #ccc;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 20px;
      }

      .cancel-btn:hover {
        background-color: #e0e0e0;
      }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">
    <div><h4>프로필 변경</h4></div>

    <!-- Profile Picture -->
    <div class="form-group">
        <label class="form-label">프로필 사진</label>
        <div class="profile-pic-container">
            <img src="/resources/image/profile.svg" alt="Profile Picture" class="profile-pic"
                 id="profilePicturePreview">
            <input type="file" accept="image/*" id="profilePictureInput" style="display: none;">
            <button class="upload-btn"
                    onclick="document.getElementById('profilePictureInput').click();">사진 변경
            </button>
        </div>
    </div>

    <!-- Name -->
    <div class="form-group">
        <label for="name" class="form-label">이름</label>
        <input type="text" id="name" class="form-input" placeholder="이름을 입력하세요"
               value="${user.name}">
        <div id="nameError" class="form-error"></div>
    </div>

    <!-- Password -->
    <div class="form-group">
        <label for="password" class="form-label">새 비밀번호</label>
        <input type="password" id="password" class="form-input" placeholder="새 비밀번호를 입력하세요">
        <div id="passwordError" class="form-error"></div>
    </div>

    <!-- Password Confirmation -->
    <div class="form-group">
        <label for="confirmPassword" class="form-label">비밀번호 확인</label>
        <input type="password" id="confirmPassword" class="form-input" placeholder="비밀번호를 다시 입력하세요">
        <div id="confirmPasswordError" class="form-error"></div>
    </div>

    <!-- Save and Cancel Buttons -->
    <div>
        <button class="save-btn" id="saveProfileBtn">저장</button>
        <button class="cancel-btn" onclick="window.location.href='/';">취소</button>
    </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    fetch('/api/me')
    .then(response => {
      if (!response.ok) {
        throw new Error('Failed to fetch user');
      }
      return response.json();
    })
    .then(data => {
      const profilePic = document.getElementById('profilePicturePreview');
      profilePic.src = data.profile || '/resources/image/profile.svg';
    })

    const profilePictureInput = document.getElementById('profilePictureInput');
    const profilePicturePreview = document.getElementById('profilePicturePreview');
    const saveProfileBtn = document.getElementById('saveProfileBtn');
    const nameInput = document.getElementById('name');
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const nameError = document.getElementById('nameError');
    const passwordError = document.getElementById('passwordError');
    const confirmPasswordError = document.getElementById('confirmPasswordError');

    // Preview profile picture
    profilePictureInput.addEventListener('change', (event) => {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
          profilePicturePreview.src = e.target.result;
        };
        reader.readAsDataURL(file);
      }
    });

    // Validate and save profile
    saveProfileBtn.addEventListener('click', async () => {
      let isValid = true;

      // Reset errors
      nameError.textContent = '';
      passwordError.textContent = '';
      confirmPasswordError.textContent = '';

      // Validate name
      if (nameInput.value.trim() === '') {
        nameError.textContent = '이름을 입력해주세요.';
        isValid = false;
      }

      // Validate password
      if (passwordInput.value.trim() !== '') {
        if (passwordInput.value !== confirmPasswordInput.value) {
          confirmPasswordError.textContent = '비밀번호가 일치하지 않습니다.';
          isValid = false;
        }
      }

      if (isValid) {
        const formData = new FormData();
        formData.append('name', nameInput.value.trim());
        if (passwordInput.value.trim() !== '') {
          formData.append('password', passwordInput.value.trim());
        }
        if (profilePictureInput.files[0]) {
          formData.append('profilePicture', profilePictureInput.files[0]);
        }

        fetch('/api/me', {
          method: 'PATCH',
          body: formData,
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('프로필 변경에 실패했습니다.');
          }
          return response;
        })
        .then(data => {
          alert('프로필이 성공적으로 변경되었습니다.');
          window.location.href = '/';
        })
      }
    });
  });

</script>
</body>
</html>
