<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
      .container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 90vh;
      }

      .register-container {
        width: 100%;
        max-width: 400px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        padding: 40px 30px;
        text-align: center;
      }

      .register-title {
        text-align: center;
        font-size: 1.5rem;
        font-weight: bold;
        color: #0747A6;
        margin-bottom: 20px;
      }

      .form-label {
        font-weight: bold;
        color: #333;
      }

      .btn-primary {
        background-color: #0747A6;
        border: none;
      }

      .btn-primary:hover {
        background-color: #0052cc;
      }

      .login-link {
        text-align: center;
        margin-top: 15px;
        font-size: 0.9rem;
      }

      .login-link a {
        color: #0747A6;
        text-decoration: none;
      }

      .login-link a:hover {
        text-decoration: underline;
      }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container mt-5">
    <div class="register-container">
        <h2 class="register-title">회원가입</h2>
        <form id="registerForm" action="/register" method="post" onsubmit="return validateForm()">
            <!-- Username -->
            <div class="mb-3">
                <label style="float: left;" for="username" class="form-label"> 아이디</label>
                <input type="text" class="form-control" id="username" name="username" required
                       placeholder="아이디를 입력하세요">
            </div>
            <!-- Password -->
            <div class="mb-3">
                <label style="float: left;" for="password" class="form-label"> 비밀번호</label>
                <input type="password" class="form-control" id="password" name="password" required
                       placeholder="비밀번호를 입력하세요">
            </div>
            <!-- Confirm Password -->
            <div class="mb-3">
                <label style="float: left;" for="confirmPassword" class="form-label"> 비밀번호 확인</label>
                <input type="password" class="form-control" id="confirmPassword"
                       name="confirmPassword" required placeholder="비밀번호를 다시 입력하세요">
            </div>
            <!-- Name -->
            <div class="mb-3">
                <label style="float: left;" for="name" class="form-label"> 이름</label>
                <input type="text" class="form-control" id="name" name="name" required
                       placeholder="이름을 입력하세요">
            </div>
            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary w-100">회원가입</button>
            <!-- Login Redirect -->
            <div class="login-link">
                <p>이미 계정이 있으신가요? <a href="/login">로그인</a></p>
            </div>
        </form>
    </div>
</div>
<script>
  function validateForm() {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    if (password !== confirmPassword) {
      alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
      return false;
    }
    return true;
  }
</script>
</body>
</html>
