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

      #dueDatePicker {
        width: 70%;
        padding: 8px 12px;
        font-size: 1rem;
        border: 1px solid #ccc;
        border-radius: 8px; /* 모서리를 둥글게 */
        background-color: #f9f9f9;
        transition: all 0.3s ease; /* 애니메이션 효과 */
      }

      /* 마우스 올릴 때 */
      #dueDatePicker:hover {
        border-color: #0052cc;
        background-color: #ffffff;
      }

      /* 입력 필드에 포커스가 있을 때 */
      #dueDatePicker:focus {
        outline: none;
        border-color: #0052cc;
        box-shadow: 0 0 5px rgba(0, 82, 204, 0.5); /* 파란색 그림자 */
        background-color: #ffffff;
      }

      /* 라벨 입력 필드 */
      .edit-label-input {
        padding: 8px 12px;
        font-size: 1rem;
        border: 1px solid #ccc;
        border-radius: 8px;
        background-color: #f9f9f9;
        transition: all 0.3s ease;
      }

      /* 라벨 저장 버튼 */
      .edit-label-btn:hover {
        background-color: #0046a5;
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
        <div class="title-section" id="titleSection" data-id="${task.key}"
             data-projectId="${task.projectId}">
            <h1 class="title-text">${task.title}</h1>
            <input type="text" class="edit-title-input" value="${task.title}">
            <button class="edit-title-btn">수정</button>
        </div>

        <!-- Task Description -->
        <div class="info">
            <div class="section-title">설명</div>
            <div class="info-value" id="taskBody" data-id="${task.key}"
                 data-projectId="${task.projectId}">
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
                <div class="info-value col-md-9 position-relative" id="labelSection" data-projectId="${task.projectId}" data-key="${task.key}">
                    <span class="label-text badge" style="width: fit-content;">${task.label}</span>
                    <input type="text" class="edit-label-input" value="${task.label}" style="display: none; width: 100%; margin-top: 5px;" />
                </div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">상태:</div>
                <div class="info-value col-md-9 position-relative">
                <span id="statusBadge"
                      class="badge
                      <c:choose>
                        <c:when test="${task.status == 'TODO'}">status-todo</c:when>
                        <c:when test="${task.status == 'IN_PROGRESS'}">status-in-progress</c:when>
                        <c:when test="${task.status == 'DONE'}">status-done</c:when>
                      </c:choose>"
                      style="cursor: pointer;"
                      data-projectId="${task.projectId}" data-key="${task.key}">
                    ${task.status}
                </span>
                    <!-- 드롭다운 메뉴 -->
                    <ul id="statusDropdown" class="dropdown-menu" style="display: none;">
                        <li class="dropdown-item status-option" data-status="TODO">
                            <div class="badge status-todo">TODO</div>
                        </li>
                        <li class="dropdown-item status-option" data-status="IN_PROGRESS">
                            <div class="badge status-in-progress">IN
                                PROGRESS
                            </div>
                        </li>
                        <li class="dropdown-item status-option" data-status="DONE">
                            <div class="badge status-done">DONE</div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">우선순위:</div>
                <div class="info-value col-md-9">
                <span id="priorityBadge"
                      class="badge
                      <c:choose>
                        <c:when test="${task.priority == 'LOW'}">priority-low</c:when>
                        <c:when test="${task.priority == 'MEDIUM'}">priority-medium</c:when>
                        <c:when test="${task.priority == 'HIGH'}">priority-high</c:when>
                      </c:choose>"
                      style="cursor: pointer;"
                      data-projectId="${task.projectId}" data-key="${task.key}">
                    ${task.priority}
                </span>
                    <!-- 드롭다운 메뉴 -->
                    <ul id="priorityDropdown" class="dropdown-menu" style="display: none;">
                        <li class="dropdown-item priority-option" data-priority="LOW">
                            <div class="badge priority-low">LOW</div>
                        </li>
                        <li class="dropdown-item priority-option" data-priority="MEDIUM">
                            <div class="badge priority-medium">MEDIUM</div>
                        </li>
                        <li class="dropdown-item priority-option" data-priority="HIGH">
                            <div class="badge priority-high">HIGH</div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">담당자:</div>
                <div class="info-value col-md-9 position-relative">
                <span style="cursor: pointer;"
                      data-projectId="${task.projectId}" data-key="${task.key}"
                      id="assigneeBadge">
                    <img src="${task.personInChargeProfile}"
                         alt="Created By Profile"
                         style="width: 30px; height: 30px; border-radius: 50%; margin-right: 10px;">${task.personInCharge}
                </span>
                    <!-- 드롭다운 메뉴 -->
                    <ul id="assigneeDropdown" class="dropdown-menu" style="display: none;">
                        <c:forEach var="user" items="${users}">
                            <li class="dropdown-item assignee-option"
                                data-assignee="${user.username}">
                                <img src="${user.profile}" alt="${user.name}"
                                     style="width: 30px; height: 30px; border-radius: 50%; margin-right: 10px;">
                                    ${user.name}
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="row mb-2">
                <div class="info-key col-md-3">목표일:</div>
                <div class="info-value col-md-9">
                    <input type="date" id="dueDatePicker"
                           value="${task.dueDate}"
                           data-projectId="${task.projectId}"
                           data-key="${task.key}" />
                </div>
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
        </div>
    </div>

</div>
<script>
  document.addEventListener('DOMContentLoaded', () => {
    const labelSection = document.getElementById('labelSection');
    const labelText = labelSection.querySelector('.label-text');
    const editLabelInput = labelSection.querySelector('.edit-label-input');

    // 라벨 클릭 시 수정 모드로 전환
    labelText.addEventListener('click', () => {
      labelText.style.display = 'none';
      editLabelInput.style.display = 'block';
      editLabelInput.focus();
    });

    // blur 이벤트를 통해 라벨 저장
    editLabelInput.addEventListener('blur', () => {
      const updatedLabel = editLabelInput.value.trim();

      // AJAX 요청으로 라벨 업데이트
      fetch('/api/projects/' + labelSection.dataset.projectid + '/tasks/' + labelSection.dataset.key + '/label', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ label: updatedLabel })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Failed to update label');
        }
        return response;
      })
      .then(data => {
        labelText.textContent = updatedLabel || 'none'; // 비어 있는 경우 기본값 설정
        labelText.style.display = 'block';
        editLabelInput.style.display = 'none';
      })
      .catch(error => {
        console.error('Error updating label:', error);
        alert('라벨 업데이트 중 오류가 발생했습니다.');
        // 오류 발생 시 원래 값 복원
        labelText.style.display = 'block';
        editLabelInput.style.display = 'none';
      });
    });

    // 입력란 외부 클릭 시 수정 취소
    document.addEventListener('click', (event) => {
      if (!labelSection.contains(event.target)) {
        labelText.style.display = 'block';
        editLabelInput.style.display = 'none';
      }
    });


    const dueDatePicker = document.getElementById('dueDatePicker');

    // 날짜 변경 시 목표일 업데이트
    dueDatePicker.addEventListener('change', function () {
      const selectedDate = dueDatePicker.value;

      if (selectedDate) {
        // AJAX 요청으로 목표일 업데이트
        fetch('/api/projects/' + dueDatePicker.dataset.projectid + '/tasks/' + dueDatePicker.dataset.key + '/due-date', {
          method: 'PATCH',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ dueDate: selectedDate })
        })
        .then(function (response) {
          if (!response.ok) {
            throw new Error('Failed to update due date');
          }
          return response;
        })
        .then(function (data) {
        })
        .catch(function (error) {
          console.error('Error updating due date:', error);
          alert('목표일 업데이트 중 오류가 발생했습니다.');
        });
      }
    });

    const assigneeBadge = document.getElementById('assigneeBadge');
    const assigneeDropdown = document.getElementById('assigneeDropdown');

    // 드롭다운 표시/숨김 토글
    assigneeBadge.addEventListener('click', function () {
      if (assigneeDropdown.style.display === 'none') {
        assigneeDropdown.style.display = 'block';
      } else {
        assigneeDropdown.style.display = 'none';
      }
    });

    // 드롭다운 옵션 클릭 시 담당자 업데이트
    const assigneeOptions = document.querySelectorAll('.assignee-option');
    assigneeOptions.forEach(function (option) {
      option.addEventListener('click', function () {
        const selectedAssignee = option.getAttribute('data-assignee');

        // AJAX 요청으로 담당자 업데이트
        fetch('/api/projects/' + assigneeBadge.dataset.projectid + '/tasks/' + assigneeBadge.dataset.key
            + '/assignee', {
          method: 'PATCH',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({personInCharge: selectedAssignee})
        })
        .then(function (response) {
          if (!response.ok) {
            throw new Error('Failed to update assignee');
          }
          return response;
        })
        .then(function (data) {
          // 담당자 업데이트 및 스타일 변경
          window.location.reload();
          assigneeDropdown.style.display = 'none';
        })
        .catch(function (error) {
          console.error('Error updating assignee:', error);
          alert('담당자 업데이트 중 오류가 발생했습니다.');
        });
      });
    });

    // 드롭다운 외부 클릭 시 닫기
    document.addEventListener('click', function (event) {
      if (!assigneeDropdown.contains(event.target) && event.target !== assigneeBadge) {
        assigneeDropdown.style.display = 'none';
      }
    });

    const priorityBadge = document.getElementById('priorityBadge');
    const priorityDropdown = document.getElementById('priorityDropdown');

    // 드롭다운 표시/숨김 토글
    priorityBadge.addEventListener('click', function () {
      if (priorityDropdown.style.display === 'none') {
        priorityDropdown.style.display = 'block';
      } else {
        priorityDropdown.style.display = 'none';
      }
    });

    // 드롭다운 옵션 클릭 시 우선순위 업데이트
    const priorityOptions = document.querySelectorAll('.priority-option');
    priorityOptions.forEach(function (option) {
      option.addEventListener('click', function () {
        const selectedPriority = option.getAttribute('data-priority');

        // AJAX 요청으로 우선순위 업데이트
        fetch('/api/projects/' + priorityBadge.dataset.projectid + '/tasks/'
            + priorityBadge.dataset.key
            + '/priority', {
          method: 'PATCH',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({priority: selectedPriority})
        })
        .then(function (response) {
          if (!response.ok) {
            throw new Error('Failed to update priority');
          }
          return response;
        })
        .then(function (data) {
          // 우선순위 업데이트 및 스타일 변경
          priorityBadge.textContent = selectedPriority;
          priorityBadge.className = 'badge ' + getPriorityBadgeClass(selectedPriority);
          priorityDropdown.style.display = 'none';
        })
        .catch(function (error) {
          console.error('Error updating priority:', error);
          alert('우선순위 업데이트 중 오류가 발생했습니다.');
        });
      });
    });

    // 드롭다운 외부 클릭 시 닫기
    document.addEventListener('click', function (event) {
      if (!priorityDropdown.contains(event.target) && event.target !== priorityBadge) {
        priorityDropdown.style.display = 'none';
      }
    });

    // 우선순위별 클래스 반환 함수
    function getPriorityBadgeClass(priority) {
      switch (priority) {
        case 'LOW':
          return 'priority-low';
        case 'MEDIUM':
          return 'priority-medium';
        case 'HIGH':
          return 'priority-high';
        default:
          return '';
      }
    }

    const statusBadge = document.getElementById('statusBadge');
    const statusDropdown = document.getElementById('statusDropdown');

    // 드롭다운 표시/숨김 토글
    statusBadge.addEventListener('click', function () {
      if (statusDropdown.style.display === 'none') {
        statusDropdown.style.display = 'block';
      } else {
        statusDropdown.style.display = 'none';
      }
    });

    // 드롭다운 옵션 클릭 시 상태 업데이트
    const statusOptions = document.querySelectorAll('.status-option');
    statusOptions.forEach(function (option) {
      option.addEventListener('click', function () {
        const selectedStatus = option.getAttribute('data-status');

        // AJAX 요청으로 상태 업데이트
        fetch('/api/projects/' + statusBadge.dataset.projectid + '/tasks/' + statusBadge.dataset.key
            + '/status', {
          method: 'PATCH',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({status: selectedStatus})
        })
        .then(function (response) {
          if (!response.ok) {
            throw new Error('Failed to update status');
          }
          return response;
        })
        .then(function (data) {
          // 상태 업데이트 및 스타일 변경
          statusBadge.textContent = selectedStatus;
          statusBadge.className = 'badge ' + getStatusBadgeClass(selectedStatus);
          statusDropdown.style.display = 'none';
        })
        .catch(function (error) {
          console.error('Error updating status:', error);
          alert('상태 업데이트 중 오류가 발생했습니다.');
        });
      });
    });

    document.addEventListener('click', function (event) {
      if (!statusDropdown.contains(event.target) && event.target !== statusBadge) {
        statusDropdown.style.display = 'none';
      }
    });

    // 상태별 클래스 반환 함수
    function getStatusBadgeClass(status) {
      switch (status) {
        case 'TODO':
          return 'status-todo';
        case 'IN_PROGRESS':
          return 'status-in-progress';
        case 'DONE':
          return 'status-done';
        default:
          return '';
      }
    }

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

        fetch(
            '/api/projects/' + titleSection.dataset.projectid + '/tasks/' + titleSection.dataset.id
            + '/title', {
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

        fetch('/api/projects/' + taskBody.dataset.projectid + '/tasks/' + taskBody.dataset.id
            + '/body', {
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
