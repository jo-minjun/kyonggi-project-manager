<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <style>
      body {
        background-color: #f4f5f7;
      }

      .projects-summary {
        margin-bottom: 40px;
      }

      .projects-summary h2 {
        font-size: 1.5rem;
        font-weight: bold;
        color: #172B4D;
      }

      .project-container {
        display: flex;
        flex-wrap: wrap;
      }

      .projects-summary .card {
        margin-bottom: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .tasks-list h2 {
        font-size: 1.5rem;
        font-weight: bold;
        color: #172B4D;
        margin-bottom: 20px;
      }

      .tasks-list .task {
        display: flex;
        justify-content: space-between;
        flex-direction: row;
        margin-bottom: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .task .task-first-section {
        display: flex;
        flex-direction: row;
        align-items: center;
      }

      .border-right {
        border-right: 1px solid #ccc;
        padding-right: 10px;
        margin-right: 10px;
      }

      .border-top {
        border-top: 1px solid #ccc;
        padding-top: 10px;
        margin-top: 10px;
      }

      .task-title {
        font-size: 1rem;
        font-weight: bold;
        color: #172B4D;
      }

      .task-status {
        text-transform: uppercase;
        font-size: 0.85rem;
        font-weight: bold;
        padding: 2px 8px;
        border-radius: 4px;
      }

      .task:hover {
        background-color: #F1F2F4;
      }

      .card:hover {
        background-color: #F1F2F4;
      }

      .status-TODO {
        background-color: #FFCC00;
        color: #000;
      }

      .status-IN_PROGRESS {
        background-color: #0052CC;
        color: #fff;
      }

      .status-DONE {
        background-color: #36B37E;
        color: #fff;
      }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<jsp:include page="taskModal.jsp"/>

<div class="container mt-5">
    <h1>안녕하세요, <span><%=session.getAttribute("loggedInUserName")%></span>님!</h1>
    <br>

    <!-- 프로젝트 요약 -->
    <div class="projects-summary border-top">
        <h2>프로젝트 목록</h2>
        <div class="row project-container">
            <c:forEach var="project" items="${projectSummaries}">
                <div class="col-md-3">
                    <a style="text-decoration: none" href="/projects/${project.projectId}">
                    <div class="card p-3" data-id="${project.projectId}">
                        <h3 style="border-bottom: 1px solid #ccc; padding: 8px;">${project.projectName}</h3>
                        <p><strong>TODO:</strong> ${project.numOfTodo}</p>
                        <p><strong>IN PROGRESS:</strong> ${project.numOfInProgress}</p>
                        <p><strong>DONE:</strong> ${project.numOfDone}</p>
                    </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 전체 태스크 목록 -->
    <div class="tasks-list">
        <h2>태스크 목록</h2>
        <c:forEach var="task" items="${tasks}">
            <div class="task p-3" data-id="${task.key}" data-projectid="${task.projectId}">
                <div class="task-first-section">
                    <div class="border-right"><h5>${task.projectName}</h5></div>
                    <div>
                        <div class="task-title">${task.title}</div>
                        <span class="task-status status-${task.status}">
                        <c:choose>
                            <c:when test="${task.status == 'TODO'}">TODO</c:when>
                            <c:when test="${task.status == 'IN_PROGRESS'}">IN PROGRESS</c:when>
                            <c:when test="${task.status == 'DONE'}">DONE</c:when>
                        </c:choose>
                        </span>
                    </div>
                </div>
                <div>${task.createdDate}</div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    // 태스크 카드 클릭 이벤트
    const taskCards = document.querySelectorAll('.task');
    taskCards.forEach(task => {
      task.addEventListener('click', () => {
        const taskId = task.getAttribute('data-id');
        const projectId = task.getAttribute('data-projectId');

        // 서버로 AJAX 요청
        fetch('/api/projects/' + projectId + '/tasks/' + taskId)
        .then(response => response.json())
        .then(data => {
          // 서버에서 받은 데이터로 모달 업데이트
          document.getElementById('modalTaskTitle').textContent = data.title || 'No Title';
          document.getElementById('modalTaskBody').textContent = data.body || 'No Body';
          document.getElementById('modalTaskLabel').textContent = data.label || 'No Label';
          document.getElementById('modalTaskPriority').textContent = data.priority || 'Unknown';
          document.getElementById('modalTaskCreatedByProfile').textContent =
              data.createdByProfile || 'Unknown';
          document.getElementById('modalTaskCreatedBy').textContent = data.createdBy || 'Unknown';
          document.getElementById('modalTaskPersonInChargeProfile').textContent =
              data.personInChargeProfile || 'Unknown';
          document.getElementById('modalTaskPersonInCharge').textContent =
              data.personInCharge || 'Unknown';
          document.getElementById('modalTaskStatus').textContent = data.status || 'Unknown';
          document.getElementById('modalTaskDueDate').textContent = data.dueDate || 'Unknown';
          document.getElementById('modalTaskCreatedAt').textContent = data.createdDate || 'Unknown';

          const projectInfo = document.querySelector('.project-info');
          projectInfo.innerHTML =
              '<a href="/">프로젝트</a> / ' +
              '<a href="/projects/' + (data.projectId || '') + '">' + (data.projectName || 'Unknown') + '</a> / ' +
              '<a href="/projects/' + (data.projectId || '') + '/tasks/' + (data.key || '') + '" target="_blank">' +
              (data.key || 'Unknown') + '</a>';

          document.getElementById('modalTaskPersonInChargeProfile').src =
              data.personInChargeProfile;
          document.getElementById('modalTaskCreatedByProfile').src =
              data.createdByProfile;

          // 모달 표시
          const taskDetailModal = new bootstrap.Modal(document.getElementById('taskDetailModal'));
          taskDetailModal.show();
        })
        .catch(error => {
          console.error('Error fetching task details:', error);
          alert('Failed to load task details. Please try again.');
        });
      });
    });
  });

</script>

</body>
</html>
