<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Modals</title>
    <!-- Bootstrap CSS -->
    <style>
      .modal-dialog {
        max-width: 60%;
        min-width: 1000px;
        height: 90%;
      }

      .project-info {
        font-size: 0.9rem;
        font-weight: bold;
        color: #5E6C84;
        margin-bottom: 10px;
      }

      .modal-content {
        height: 100%;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }

      .modal-header {
        background-color: #f4f5f7;
        border-bottom: 1px solid #e0e0e0;
        padding: 16px 20px;
      }

      .modal-title {
        font-weight: bold;
        color: #172b4d;
      }

      .modal-body {
        display: flex;
        flex-direction: row;
        padding: 20px;
        gap: 20px;
        height: 90%;
      }

      .modal-left {
        flex: 2;
        border-right: 1px solid #e0e0e0;
        padding-right: 20px;
        height: 100%;
        overflow-y: auto;
      }

      .modal-left h6 {
        font-size: 1.1rem;
        font-weight: bold;
        color: #5e6c84;
        margin-bottom: 10px;
      }

      .modal-left p {
        font-size: 1rem;
        color: #172b4d;
        line-height: 1.5;
        white-space: pre-wrap;
      }

      .modal-right {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 10px;
      }

      .modal-right .label {
        font-size: 0.9rem;
        font-weight: bold;
        color: #5e6c84;
      }

      .modal-right .value {
        font-size: 0.9rem;
        color: #172b4d;
        text-align: right;
      }

      .additionalInfo {
        display: flex;
        flex-direction: row;
        padding: 8px 0;
      }

      .additionalInfoKey {
        width: 30%;
      }

      .label-value {
        font-size: 0.9rem;
        padding: 3px 8px;
        border-radius: 5px;
        background-color: #3182ce;
        color: #fff;
        display: inline-block;
        margin-bottom: 10px;
        text-align: right;
      }

      /* 상태별 색상 */
      .status-todo {
        background-color: #ffcc00; /* Yellow */
        color: #000;
        font-size: 0.9rem;
        padding: 3px 8px;
        border-radius: 5px;
      }

      .status-in-progress {
        background-color: #007bff; /* Blue */
        color: #fff;
        font-size: 0.9rem;
        padding: 3px 8px;
        border-radius: 5px;
      }

      .status-done {
        background-color: #28a745; /* Green */
        color: #fff;
        font-size: 0.9rem;
        padding: 3px 8px;
        border-radius: 5px;
      }

      /* Priority 별 색상 */
      .priority-low {
        background-color: #17a2b8; /* Light Blue */
        color: #fff;
        font-size: 0.9rem;
        padding: 3px 8px;
        border-radius: 5px;
      }

      .priority-medium {
        background-color: #ffc107; /* Yellow */
        color: #000;
        font-size: 0.9rem;
        padding: 3px 8px;
        border-radius: 5px;
      }

      .priority-high {
        background-color: #dc3545; /* Red */
        color: #fff;
        font-size: 0.9rem;
        padding: 3px 8px;
        border-radius: 5px;
      }

      .modal-footer {
        padding: 16px 20px;
        background-color: #f4f5f7;
        border-top: 1px solid #e0e0e0;
      }

      .btn-secondary {
        background-color: #e0e0e0;
        color: #5e6c84;
      }

      .btn-primary {
        background-color: #0052cc;
        color: #fff;
      }
    </style>
</head>
<body>
<!-- Task Detail Modal -->
<div class="modal fade" id="taskDetailModal" tabindex="-1" aria-labelledby="taskDetailModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTaskTitle">Task Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 왼쪽: Body -->
                <div class="modal-left">
                    <h6>설명</h6>
                    <p id="modalTaskBody">Task body content here</p>
                </div>

                <!-- 오른쪽: 추가 정보 -->
                <div class="modal-right">
                    <div class="project-info">
                    </div>

                    <div class="additionalInfo">
                        <div class="label additionalInfoKey">라벨:</div>
                        <div class="label-value" id="modalTaskLabel"></div>
                    </div>
                    <div class="additionalInfo">
                        <div class="label additionalInfoKey">상태:</div>
                        <div id="modalTaskStatus"></div>
                    </div>
                    <div class="additionalInfo">
                        <div class="label additionalInfoKey">우선순위:</div>
                        <div id="modalTaskPriority"></div>
                    </div>
                    <div class="additionalInfo">
                        <div class="label additionalInfoKey">담당자:</div>
                        <div class="value">
                            <span id="modalTaskPersonInChargeProfile"></span> <span
                                id="modalTaskPersonInCharge"></span>
                        </div>
                    </div>
                    <div class="additionalInfo">
                        <div class="label additionalInfoKey">생성자:</div>
                        <div class="value">
                            <span id="modalTaskCreatedByProfile"></span> <span
                                id="modalTaskCreatedBy"></span>
                        </div>
                    </div>
                    <div class="additionalInfo">
                        <div class="label additionalInfoKey">생성일:</div>
                        <div class="value" id="modalTaskCreatedAt"></div>
                    </div>
                    <div class="additionalInfo">
                        <div class="label additionalInfoKey">목표일:</div>
                        <div class="value" id="modalTaskDueDate"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Add Task Modal -->
<div class="modal fade" id="addTaskModal" tabindex="-1" aria-labelledby="addTaskModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addTaskModalLabel">Add New Task</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addTaskForm">
                    <div class="mb-3">
                        <label for="taskTitle" class="form-label">Task Title</label>
                        <input type="text" class="form-control" id="taskTitle" required>
                    </div>
                    <div class="mb-3">
                        <label for="taskBody" class="form-label">Task Body</label>
                        <input type="text" class="form-control" id="taskBody" required>
                    </div>
                    <div class="mb-3">
                        <label for="taskLabel" class="form-label">Label</label>
                        <input type="text" class="form-control" id="taskLabel" required>
                    </div>
                    <div class="mb-3">
                        <label for="taskPriority" class="form-label">Priority</label>
                        <select class="form-select" id="taskPriority" required>
                            <option value="LOW">Low</option>
                            <option value="MEDIUM">Medium</option>
                            <option value="HIGH">High</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="personInCharge" class="form-label">Person In Charge</label>
                        <input type="text" class="form-control" id="personInCharge" required>
                    </div>
                    <div class="mb-3">
                        <label for="dueDate" class="form-label">Due Date</label>
                        <input type="date" class="form-control" id="dueDate" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel
                </button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal"
                        onclick="addTask()">Add Task
                </button>
            </div>
        </div>
    </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    function updateStatusStyle() {
      const statusElement = document.getElementById('modalTaskStatus');
      const status = statusElement.textContent.trim().toUpperCase();

      // Remove all existing classes
      statusElement.classList.remove('status-todo', 'status-in-progress', 'status-done');

      // Add class based on the status
      if (status === 'TODO') {
        statusElement.classList.add('status-todo');
      } else if (status === 'IN_PROGRESS') {
        statusElement.classList.add('status-in-progress');
      } else if (status === 'DONE') {
        statusElement.classList.add('status-done');
      }
    }

    function updatePriorityStyle() {
      const priorityElement = document.getElementById('modalTaskPriority');
      const priority = priorityElement.textContent.trim().toUpperCase();

      // Remove all existing classes
      priorityElement.classList.remove('priority-low', 'priority-medium', 'priority-high');

      // Add class based on the priority
      if (priority === 'LOW') {
        priorityElement.classList.add('priority-low');
      } else if (priority === 'MEDIUM') {
        priorityElement.classList.add('priority-medium');
      } else if (priority === 'HIGH') {
        priorityElement.classList.add('priority-high');
      }
    }

    // 모달 표시 전에 상태와 우선순위 업데이트
    const taskDetailModal = document.getElementById('taskDetailModal');
    taskDetailModal.addEventListener('show.bs.modal', () => {
      updateStatusStyle();
      updatePriorityStyle();
    });
  });
</script>

<!-- Bootstrap JS Bundle -->
</body>
</html>
