<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Details</title>
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
        display: flex;
        flex-direction: row;
        gap: 20px;
      }

      .left-panel {
        flex: 2;
        padding-right: 20px;
      }

      .right-panel {
        flex: 1;
        border-left: 1px solid #e0e0e0;
        padding-left: 20px;
      }

      .project-info {
        font-size: 0.9rem;
        font-weight: bold;
        color: #5E6C84;
        margin-bottom: 10px;
      }

      .section-title {
        font-size: 1.2rem;
        font-weight: bold;
        color: #5E6C84;
        margin-bottom: 10px;
      }

      .title-section {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 20px;
      }

      .title-text {
        font-size: 1.5rem;
        font-weight: bold;
        color: #172B4D;
        margin: 0;
        cursor: pointer;
        width: 95%;
        padding-top: 10px;
        padding-bottom: 10px;
      }

      .title-text:hover {
        background-color: #f0f0f0;
        cursor: pointer;
      }

      .edit-title-input {
        display: none;
        width: 100%;
        font-size: 1.5rem;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
      }

      .edit-title-btn {
        display: none;
        padding: 5px 10px;
        background-color: #0052CC;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 0.9rem;
        cursor: pointer;
        width: 5%;
      }

      .editing .edit-title-input {
        display: inline-block;
      }

      .editing .title-text {
        display: none;
      }

      .editing .edit-title-btn {
        display: inline-block;
      }

      .info {
        margin-bottom: 20px;
      }

      .info-value {
        color: #172B4D;
        position: relative;
      }

      .info-value:hover {
        background-color: #f0f0f0;
        cursor: pointer;
      }

      .edit-btn {
        display: none;
        position: absolute;
        transform: translateY(-50%);
        padding: 5px 10px;
        background-color: #0052CC;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 0.9rem;
        cursor: pointer;
        bottom: 2px;
        right: 15px;
      }

      .info-value.editing .edit-btn {
        display: inline-block;
      }

      .edit-input {
        display: none;
        width: 100%;
        margin-top: 10px;
        font-size: 1rem;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
      }

      .edit-input::-webkit-scrollbar {
        display: none;
      }

      .info-value.editing .edit-input {
        display: block;
      }

      .info-value.editing .info-text {
        display: none;
        white-space: pre-wrap; /* 줄바꿈 및 공백 유지 */
        word-wrap: break-word; /* 긴 단어가 있을 경우 줄 바꿈 */
      }

      .info-value .info-text {
        white-space: pre-wrap; /* 줄바꿈 및 공백 유지 */
        word-wrap: break-word; /* 긴 단어가 있을 경우 줄 바꿈 */
        border-radius: 8px;
      }

      .info-key {
        font-weight: bold;
        color: #5E6C84;
        width: 150px;
      }

      .badge {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 4px;
        font-size: 0.9rem;
        background-color: #3182ce;
        color: #fff;
      }

      /* 라벨 색상 */
      .label-red {
        background-color: #FF6B6B;
      }

      .label-blue {
        background-color: #4D9EF6;
      }

      .label-green {
        background-color: #36B37E;
      }

      /* 상태 색상 */
      .status-todo {
        background-color: #FFCC00;
        color: #000;
      }

      .status-in-progress {
        background-color: #0052CC;
        color: #FFF;
      }

      .status-done {
        background-color: #28A745;
        color: #FFF;
      }

      /* 우선순위 색상 */
      .priority-low {
        background-color: #17A2B8;
        color: #FFF;
      }

      .priority-medium {
        background-color: #FFC107;
        color: #000;
      }

      .priority-high {
        background-color: #DC3545;
        color: #FFF;
      }

      .footer-btns {
        text-align: right;
      }

      .btn-secondary {
        background-color: #e0e0e0;
        color: #5e6c84;
      }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">

    <div class="left-panel">
        <!-- Project and Task ID -->
        <div class="project-info">
            <a href="/">프로젝트</a> /
            <a href="/projects/${task.projectId}">${task.projectName}</a> /
            <a href="/projects/${task.projectId}/tasks/${task.key}" target="_blank">${task.key}</a>
        </div>

        <!-- Task Title -->
        <div class="title-section" id="titleSection" data-id="${task.key}" data-projectId="${task.projectId}">
            <h1 class="title-text">${task.title}</h1>
            <input type="text" class="edit-title-input" value="${task.title}">
            <button class="edit-title-btn">수정</button>
        </div>

        <!-- Task Description -->
        <div class="info">
            <div class="section-title">설명</div>
            <div class="info-value" id="taskBody" data-id="${task.key}" data-projectId="${task.projectId}">
                <p class="info-text" style="min-height: 80px">${task.body}</p>
                <textarea class="edit-input">${task.body}</textarea>
                <button class="edit-btn">수정</button>
            </div>
        </div>
    </div>

    <div class="right-panel">
        <!-- Additional Information -->
        <div class="section-title" style="margin-bottom: 10px">세부 사항</div>
        <div class="info">
            <div class="row mb-2">
                <div class="info-key col-md-3">라벨:</div>
                <div class="info-value col-md-9">
                    <span class="badge">${task.label}</span>
                </div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">상태:</div>
                <div class="info-value col-md-9">
                <span class="badge
                  <c:choose>
                    <c:when test="${task.status == 'TODO'}">status-todo</c:when>
                    <c:when test="${task.status == 'IN_PROGRESS'}">status-in-progress</c:when>
                    <c:when test="${task.status == 'DONE'}">status-done</c:when>
                  </c:choose>
                ">${task.status}</span>
                </div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">우선순위:</div>
                <div class="info-value col-md-9">
                <span class="badge
                  <c:choose>
                    <c:when test="${task.priority == 'LOW'}">priority-low</c:when>
                    <c:when test="${task.priority == 'MEDIUM'}">priority-medium</c:when>
                    <c:when test="${task.priority == 'HIGH'}">priority-high</c:when>
                  </c:choose>
                ">${task.priority}</span>
                </div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">담당자:</div>
                <div class="info-value col-md-9"><img src="${task.personInChargeProfile}"
                                                      alt="Created By Profile"
                                                      style="width: 30px; height: 30px; border-radius: 50%; margin-right: 10px;">${task.personInCharge}</div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">생성자:</div>
                <div class="info-value col-md-9"><img src="${task.createdByProfile}"
                                                      alt="Created By Profile"
                                                      style="width: 30px; height: 30px; border-radius: 50%; margin-right: 10px;">${task.createdBy}
                </div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">생성일:</div>
                <div class="info-value col-md-9">${task.createdDate}</div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">목표일:</div>
                <div class="info-value col-md-9">${task.dueDate}</div>
            </div>
        </div>
    </div>

</div>
<script>
  document.addEventListener('DOMContentLoaded', () => {
    const titleSection = document.getElementById('titleSection');
    const titleText = titleSection.querySelector('.title-text');
    const editTitleInput = titleSection.querySelector('.edit-title-input');
    const editTitleBtn = titleSection.querySelector('.edit-title-btn');

    // 제목 클릭 시 수정 모드로 전환
    titleText.addEventListener('click', () => {
      titleSection.classList.add('editing');
      editTitleInput.focus();
    });

    // 수정 버튼 클릭 시 제목 업데이트
    editTitleBtn.addEventListener('click', () => {
      const updatedTitle = editTitleInput.value.trim();
      if (updatedTitle) {
        titleText.textContent = updatedTitle;

        fetch('/api/projects/' + titleSection.dataset.projectid + '/tasks/' + titleSection.dataset.id + '/title', {
          method: 'PATCH',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({
            title: updatedTitle
          })
        })
        .then(response => response.json())
        .then(data => console.log('Updated successfully:', data));

        titleSection.classList.remove('editing');
        alert('제목이 수정되었습니다.');
      } else {
        alert('제목을 입력해주세요.');
      }
    });

    // 입력란 외부 클릭 시 수정 취소
    document.addEventListener('click', (event) => {
      if (!titleSection.contains(event.target)) {
        titleSection.classList.remove('editing');
      }
    });

    const taskBody = document.getElementById('taskBody');
    const editButton = taskBody.querySelector('.edit-btn');
    const editInput = taskBody.querySelector('.edit-input');
    const infoText = taskBody.querySelector('.info-text');

    function autoResizeTextarea(element) {
      element.style.height = 'auto'; // 기존 높이 초기화
      element.style.height = element.scrollHeight + 'px'; // 스크롤 높이에 맞춰 재설정
    }

    // 설명 부분을 클릭했을 때 수정 버튼 나타나기
    taskBody.addEventListener('click', () => {
      taskBody.classList.add('editing');
      editInput.focus(); // 수정 모드로 진입 시 커서 자동 포커스
      autoResizeTextarea(editInput); // 초기 높이 조정
    });

    editInput.addEventListener('input', () => {
      autoResizeTextarea(editInput);
    });

    // 수정 버튼 클릭 시 수정 내용 처리
    editButton.addEventListener('click', (event) => {
      event.stopPropagation(); // 클릭 이벤트 전파 방지
      const updatedValue = editInput.value.trim();
      if (updatedValue !== '') {
        infoText.textContent = updatedValue;

        fetch('/api/projects/' + taskBody.dataset.projectid + '/tasks/' + taskBody.dataset.id + '/body', {
          method: 'PATCH',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({
            body: updatedValue
          })
        })
        .then(response => response.json())
        .then(data => console.log('Updated successfully:', data));

        alert('설명이 수정되었습니다.');
        taskBody.classList.remove('editing');
      } else {
        alert('설명을 입력해주세요.');
      }
    });

    // 입력란 외부를 클릭하면 수정 취소
    document.addEventListener('click', (event) => {
      if (!taskBody.contains(event.target)) {
        taskBody.classList.remove('editing');
      }
    });
  });
</script>
</body>
</html>
