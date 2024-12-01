<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JIRA-Style Kanban Board</title>
    <style>
      body {
        background-color: #f4f5f7;
      }

      .board {
        display: flex;
        justify-content: center;
      }

      .board-column {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        background-color: #F4F5F7;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 15px;
        height: 100%;
      }

      .board-column-header {
        font-size: 1.2rem;
        font-weight: bold;
        margin-bottom: 15px;
        text-transform: uppercase;
        color: #4a5568;
      }

      .kanban-item {
        background-color: #ffffff;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-bottom: 10px;
        padding: 15px;
        cursor: grab;
        transition: all 0.2s ease-in-out;
        border-left: 5px solid #ecc94b; /* Yellow for TODO */
      }

      .kanban-item:hover {
        transform: scale(1.02);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      }

      .kanban-item .label {
        font-size: 0.9rem;
        padding: 3px 8px;
        border-radius: 5px;
        background-color: #3182ce;
        color: #fff;
        display: inline-block;
        margin-bottom: 10px;
      }

      .kanban-item-bottom {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 10px;
      }

      .kanban-item[data-status="IN_PROGRESS"] {
        border-left: 5px solid #3182ce; /* Blue for In Progress */
      }

      .kanban-item[data-status="DONE"] {
        border-left: 5px solid #48bb78; /* Green for Done */
      }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<jsp:include page="taskModal.jsp"/>


<div class="container mt-5">

    <!-- Filter Section -->
    <div class="row mb-3">
        <div class="col-md-6">
            <label for="filterPerson" class="form-label">담당자로 필터링</label>
            <select id="filterPerson" class="form-select">
                <option value="">All</option>
                <c:forEach var="personFilter" items="${personFilters}">
                    <option value="${personFilter}">${personFilter}</option>
                </c:forEach>
            </select>
        </div>

        <div class="col-md-6">
            <label for="filterLabel" class="form-label">라벨로 필터링</label>
            <select id="filterLabel" class="form-select">
                <option value="">All</option>
                <c:forEach var="labelFilter" items="${labelFilters}">
                    <option value="${labelFilter}">${labelFilter}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="board row gy-4">
        <!-- TODO Column -->
        <div class="col-md-4">
            <div class="board-column" ondragover="allowDrop(event)" ondrop="drop(event)">
                <div>
                    <div class="board-column-header">TODO</div>
                    <div id="TODO" class="kanban-items">
                        <c:forEach var="task" items="${tasks}">
                            <c:if test="${task.status == 'TODO'}">
                                <div class="kanban-item" draggable="true" ondragstart="drag(event)"
                                     data-status="${task.status}"
                                     data-id="${task.key}"
                                     data-projectId="${task.projectId}">
                                    <div class="label">${task.label}</div>
                                    <h5>${task.title}</h5>
                                    <div class="kanban-item-bottom">
                                        <div><small><strong>ID:</strong> ${task.key}</small></div>
                                        <div><strong>담당자:</strong> ${task.personInCharge}</div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <button class="btn btn-primary mt-3 w-100" data-bs-toggle="modal"
                        data-bs-target="#addTaskModal">
                    + Add Task
                </button>
            </div>
        </div>

        <!-- In Progress Column -->
        <div class="col-md-4">
            <div class="board-column" ondragover="allowDrop(event)" ondrop="drop(event)">
                <div>
                    <div class="board-column-header">In Progress</div>
                    <div id="IN_PROGRESS" class="kanban-items">
                        <c:forEach var="task" items="${tasks}">
                            <c:if test="${task.status == 'IN_PROGRESS'}">
                                <div class="kanban-item" draggable="true" ondragstart="drag(event)"
                                     data-status="${task.status}"
                                     data-id="${task.key}"
                                     data-projectId="${task.projectId}">
                                    <div class="label">${task.label}</div>
                                    <h5>${task.title}</h5>
                                    <div class="kanban-item-bottom">
                                        <div><small><strong>ID:</strong> ${task.key}</small></div>
                                        <div><strong>담당자:</strong> ${task.personInCharge}</div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <div></div>
            </div>
        </div>

        <!-- Done Column -->
        <div class="col-md-4">
            <div class="board-column" ondragover="allowDrop(event)" ondrop="drop(event)">
                <div>
                    <div class="board-column-header">Done</div>
                    <div id="DONE" class="kanban-items">
                        <c:forEach var="task" items="${tasks}">
                            <c:if test="${task.status == 'DONE'}">
                                <div class="kanban-item" draggable="true" ondragstart="drag(event)"
                                     data-status="${task.status}"
                                     data-id="${task.key}"
                                     data-projectId="${task.projectId}">
                                    <div class="label">${task.label}</div>
                                    <h5>${task.title}</h5>
                                    <div class="kanban-item-bottom">
                                        <div><small><strong>ID:</strong> ${task.key}</small></div>
                                        <div><strong>담당자:</strong> ${task.personInCharge}</div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <div></div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
  document.addEventListener('DOMContentLoaded', () => {
    registerClick();
  });

  let draggedItem = null;

  // 드래그 시작
  function drag(event) {
    draggedItem = event.target; // 드래그 중인 요소 저장
    event.dataTransfer.setData("text", event.target.id); // 드래그 중인 요소의 ID 저장
  }

  // 드롭 허용
  function allowDrop(event) {
    event.preventDefault(); // 기본 드롭 방지
  }

  // 드롭 처리
  function drop(event) {
    event.preventDefault();

    // 드롭된 위치의 부모 컬럼 탐색
    const target = event.target;
    let dropTarget = target;

    while (dropTarget && !dropTarget.classList.contains('board-column')) {
      dropTarget = dropTarget.parentElement;
    }

    if (!dropTarget) {
      return;
    }

    // 드래그된 요소 이동
    const kanbanItems = dropTarget.querySelector('.kanban-items');
    if (kanbanItems) {
      kanbanItems.appendChild(draggedItem);
    }

    // 상태 업데이트
    const status = kanbanItems.id;
    draggedItem.dataset.status = status;

    // 서버로 상태 업데이트 요청 (AJAX)
    fetch('/api/projects/' + draggedItem.dataset.projectid + '/tasks/' + draggedItem.dataset.id + '/status', {
      method: 'PATCH',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        status: status
      })
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        console.log(`Task ${draggedItem.id} updated to ${status}`);
      } else {
        console.error(`Failed to update task ${draggedItem.id}`);
      }
    })
    .catch(error => console.error('Error:', error));
  }

  function registerClick() {
    const taskCards = document.querySelectorAll('.kanban-item');

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
          document.getElementById('modalTaskCreatedByProfile').textContent = data.createdByProfile
              || 'Unknown';
          document.getElementById('modalTaskCreatedBy').textContent = data.createdBy || 'Unknown';
          document.getElementById(
              'modalTaskPersonInChargeProfile').textContent = data.personInChargeProfile
              || 'Unknown';
          document.getElementById('modalTaskPersonInCharge').textContent = data.personInCharge
              || 'Unknown';
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
  }

  function addTask() {
    // 입력 값 가져오기
    const title = document.getElementById('taskTitle').value.trim();
    const body = document.getElementById('taskBody').value;
    const label = document.getElementById('taskLabel').value.trim();
    const priority = document.getElementById('taskPriority').value
    const personInCharge = document.getElementById('personInChargeDropdown').dataset.selected;
    const dueDate = document.getElementById('dueDate').value;

    // 입력 값 검증
    if (!title || !body || !label || !personInCharge) {
      alert('All fields are required!');
      return;
    }

    const currentUrl = window.location.href;

    const segments = currentUrl.split('/'); // URL을 "/"로 나눔
    const projectId = segments[segments.length - 1].replaceAll('#', '');

    // 서버로 요청 보내기
    const url = '/api/projects/' + projectId + '/tasks';
    fetch(url, {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        title,
        body,
        label,
        priority,
        personInCharge,
        dueDate,
        status: 'TODO' // 기본 상태
      })
    })
    .then(response => {
      return response.json();
    })
    .then(task => {
      // 서버에서 반환된 Task 데이터를 사용하여 화면에 반영
      addTaskToUI(task);
      updateFilterOptions(task.personInCharge, task.label); // 필터 옵션 업데이트
      registerClick();

      // 모달 닫기 및 폼 리셋
      const addTaskModal = bootstrap.Modal.getInstance(document.getElementById('addTaskModal'));
      addTaskModal.hide();
      document.getElementById('addTaskForm').reset();
    })
    .catch(error => {
      console.error('Error:', error);
      alert('Failed to add task. Please try again.');
    });
  }

  // 화면에 Task 추가하는 함수
  function addTaskToUI(task) {
    const newTask = document.createElement('div');
    newTask.classList.add('kanban-item');
    newTask.setAttribute('draggable', 'true');
    newTask.setAttribute('ondragstart', 'drag(event)');
    newTask.setAttribute('data-status', task.status);
    newTask.setAttribute('data-id', task.key);
    newTask.setAttribute('data-projectId', task.projectId);

    newTask.innerHTML =
        '<div class="label">' + task.label + '</div>' +
        '<h5>' + task.title + '</h5>' +
        '<div class="kanban-item-bottom">' +
        '<div><small><strong>ID: </strong>' + task.key + '</small></div>' +
        '<div><strong>담당자: </strong>' + task.personInCharge + '</div>' +
        '</div>';

    // TODO 열에 추가
    document.getElementById('TODO').appendChild(newTask);
  }

  function updateFilterOptions(newPerson, newLabel) {
    const filterPerson = document.getElementById('filterPerson');
    if (!Array.from(filterPerson.options).some(option => option.value === newPerson)) {
      const newOption = document.createElement('option');
      newOption.value = newPerson;
      newOption.textContent = newPerson;
      filterPerson.appendChild(newOption);
    }

    const filterLabel = document.getElementById('filterLabel');
    if (!Array.from(filterLabel.options).some(option => option.value === newLabel)) {
      const newOption = document.createElement('option');
      newOption.value = newLabel;
      newOption.textContent = newLabel;
      filterLabel.appendChild(newOption);
    }
  }

  document.getElementById('filterPerson').addEventListener('change', applyFilters);
  document.getElementById('filterLabel').addEventListener('change', applyFilters);

  function applyFilters() {
    const personInCharge = document.getElementById('filterPerson').value;
    const label = document.getElementById('filterLabel').value;

    const tasks = document.querySelectorAll('.kanban-item');

    tasks.forEach(task => {
      const taskPerson = task.querySelector(
          '.kanban-item-bottom div:nth-child(2)').textContent.split(': ')[1];
      const taskLabel = task.querySelector('.label').textContent;

      const matchesPerson = !personInCharge || taskPerson === personInCharge;
      const matchesLabel = !label || taskLabel === label;

      if (matchesPerson && matchesLabel) {
        task.style.display = 'block';
      } else {
        task.style.display = 'none';
      }
    });
  }
</script>
</body>
</html>
