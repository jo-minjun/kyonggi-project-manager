<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>

      .container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 90vh;
      }

      .login-container {
        width: 100%;
        max-width: 400px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        padding: 40px 30px;
        text-align: center;
      }

      .login-logo {
        font-size: 1.5rem;
        font-weight: bold;
        color: #0747A6;
        margin-bottom: 20px;
      }

      .form-control {
        margin-bottom: 20px;
      }

      .btn-primary {
        width: 100%;
        background-color: #0052cc;
        color: #ffffff;
        border: none;
        font-weight: bold;
        padding: 10px;
        font-size: 1rem;
        transition: background-color 0.3s ease;
      }

      .btn-primary:hover {
        background-color: #003d99;
      }

      .login-footer {
        margin-top: 20px;
        font-size: 0.9rem;
      }

      .login-footer a {
        color: #0052cc;
        text-decoration: none;
        font-weight: bold;
      }

      .login-footer a:hover {
        text-decoration: underline;
      }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container mt-5">
    <div class="login-container">
        <div class="login-logo">
            <i class="fa-solid fa-list-check"></i> Project Board
        </div>
        <form action="/login" method="POST">
            <input type="text" name="username" class="form-control" placeholder="Username" required>
            <input type="password" name="password" class="form-control" placeholder="Password"
                   required>
            <c:if test="${not empty error}">
                <div class="text-danger mb-3">${error}</div>
            </c:if>
            <button type="submit" class="btn btn-primary">Log In</button>
        </form>
        <div class="login-footer">
            <p>계정이 없으신가요? <a href="/signup">회원가입</a></p>
        </div>
    </div>
</div>
</body>
</html>
