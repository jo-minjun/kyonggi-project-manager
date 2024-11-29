<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>에러 발생</title>
    <style>
      body {
        background-color: #f4f5f7;
        font-family: Arial, sans-serif;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        margin: 0;
      }

      .error-container {
        text-align: center;
        background-color: #fff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        max-width: 400px;
        width: 100%;
      }

      .error-title {
        font-size: 2rem;
        font-weight: bold;
        color: #ff6b6b;
        margin-bottom: 20px;
      }

      .error-message {
        font-size: 1rem;
        color: #5e6c84;
        margin-bottom: 30px;
      }

      .error-code {
        font-size: 0.9rem;
        color: #9aa0a6;
        margin-bottom: 20px;
      }

      .btn {
        display: inline-block;
        padding: 10px 20px;
        font-size: 1rem;
        color: #fff;
        background-color: #0052cc;
        text-decoration: none;
        border-radius: 6px;
        transition: background-color 0.3s ease;
      }

      .btn:hover {
        background-color: #0041a3;
      }

      .support-link {
        margin-top: 20px;
        display: block;
        font-size: 0.9rem;
        color: #0052cc;
        text-decoration: none;
        transition: color 0.3s ease;
      }

      .support-link:hover {
        color: #003a87;
      }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-title">오류 발생!</div>
    <div class="error-message">
        요청을 처리하는 중 문제가 발생했습니다.
    </div>
    <div class="error-code">
        오류 코드: <span><%= request.getAttribute("javax.servlet.error.status_code") %></span>
    </div>
    <a href="/" class="btn">홈으로 이동</a>
</div>
</body>
</html>
