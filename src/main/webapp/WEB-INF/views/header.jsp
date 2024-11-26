<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kanban Board</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
          rel="stylesheet">
    <style>
      /* Header Styles */
      .header {
        background-color: #0747A6;
        color: white;
        padding: 10px 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
      }

      .title {
        font-size: 1.5rem;
        font-weight: bold;
        color: white;
      }

      .nav {
        display: flex;
        gap: 20px;
        align-items: center;
      }

      .nav-link {
        color: white;
        text-decoration: none;
        font-size: 1rem;
        transition: color 0.3s ease;
      }

      .nav-link:hover {
        color: #FFD700;
      }

      .dropdown-menu {
        background-color: white;
        border: 1px solid #ccc;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }

      .dropdown-item {
        font-size: 0.9rem;
        color: #000;
        transition: background-color 0.3s ease;
      }

      .dropdown-item:hover {
        background-color: #f4f5f7;
      }

      .search-box {
        position: relative;
      }

      .search-input {
        padding: 5px 30px 5px 10px;
        border: none;
        border-radius: 4px;
        font-size: 1rem;
      }

      .search-icon {
        position: absolute;
        top: 50%;
        right: 10px;
        transform: translateY(-50%);
        color: #555;
      }

      .profile {
        display: flex;
        align-items: center;
        position: relative;
      }

      .notification-icon {
        font-size: 1.5rem;
        color: white;
        cursor: pointer;
        transition: color 0.3s ease;
      }

      .notification-icon:hover {
        color: #FFD700;
      }

      .profile-pic {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        border: 2px solid white;
        cursor: pointer;
        transition: border-color 0.3s ease;
      }

      .profile-pic:hover {
        border-color: #FFD700;
      }
    </style>
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="container-fluid d-flex align-items-center justify-content-between">
        <!-- Logo and Title -->
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-list-check"></i>
            <a href="/" style="text-decoration: none">
                <span class="title ms-3">Project Board</span>
            </a>
        </div>

        <!-- Navigation Menu -->
        <nav class="nav">
            <a href="#dashboard" class="nav-link">Dashboard</a>
            <a href="#board" class="nav-link">Board</a>
            <a href="#reports" class="nav-link">Reports</a>

            <!-- Projects Dropdown -->
            <div class="dropdown">
                <a href="#" class="nav-link dropdown-toggle" id="projectsDropdown"
                   data-bs-toggle="dropdown" aria-expanded="false">
                    Projects
                </a>
                <ul class="dropdown-menu" id="projectsMenu" aria-labelledby="projectsDropdown">
                    <!-- 고정된 "프로젝트 만들기" 항목 -->
                    <li><a class="dropdown-item text-primary" href="/projects/create">프로젝트 만들기</a></li>
                    <li><hr class="dropdown-divider"></li>
                </ul>
            </div>
        </nav>

        <!-- Search and Profile -->
        <div class="d-flex align-items-center">
            <div class="search-box">
                <input type="text" placeholder="Search" class="search-input">
                <i class="fas fa-search search-icon"></i>
            </div>
            <div class="profile ms-4 dropdown">
                <i class="fas fa-bell notification-icon"></i>
                <img src="/resources/image/profile.svg" alt="User"
                     class="profile-pic ms-3 dropdown-toggle" id="profileDropdown"
                     data-bs-toggle="dropdown" aria-expanded="false">
                <%
                    // 세션에서 사용자 정보 확인
                    String username = (String) session.getAttribute("loggedInUser");
                    if (username != null) {
                %>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                    <li><a class="dropdown-item" href="/edit-profile">내 정보 수정</a></li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li><a class="dropdown-item text-danger" href="/logout">로그아웃</a></li>
                </ul>
                <%
                } else {
                %>
                <!-- 세션이 없을 경우, 아무것도 표시하지 않음 -->
                <%
                    }
                %>
            </div>
        </div>
    </div>
</header>

<!-- JavaScript -->
<script>
  document.addEventListener('DOMContentLoaded', () => {
    // AJAX 요청
    fetch('/api/projects')
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      const projectsMenu = document.getElementById('projectsMenu');

      // 기존 "프로젝트 만들기"와 구분선을 제외한 동적 항목 제거
      const staticItems = projectsMenu.querySelectorAll('li:not(:first-child):not(:nth-child(2))');
      staticItems.forEach(item => item.remove());

      // 동적으로 프로젝트 목록 추가
      data.forEach(project => {
        const menuItem = document.createElement('li');
        menuItem.innerHTML = '<a class="dropdown-item" href="/projects/' + project.id + '">' + project.name + '</a>';
        projectsMenu.appendChild(menuItem);
      });
    })
    .catch(error => {
      console.error('There has been a problem with your fetch operation:', error);
      const projectsMenu = document.getElementById('projectsMenu');
      projectsMenu.innerHTML = '<li><a class="dropdown-item text-danger">로그인을 해주세요.</a></li>';
    });
  });
</script>


<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/5b0bf82961.js" crossorigin="anonymous"></script>
</body>
</html>
