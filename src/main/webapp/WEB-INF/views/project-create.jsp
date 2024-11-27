<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Project</title>
  <style>
    /* Project Create Modal Styles */
    .modal-dialog {
      max-width: 600px;
    }

    .modal-header {
      background-color: #0747A6;
      color: white;
      padding: 20px;
    }

    .modal-title {
      font-weight: bold;
    }

    .modal-body {
      padding: 20px;
    }

    .modal-form {
      width: 100%;
    }

    .form-label {
      font-size: 0.9rem;
      font-weight: bold;
      color: #5e6c84;
    }

    .form-control {
      font-size: 0.9rem;
    }

    .btn-primary {
      background-color: #0052CC;
      border: none;
    }

    .btn-primary:hover {
      background-color: #0043A6;
    }

    .btn-secondary {
      background-color: #E0E0E0;
      color: #5e6c84;
    }

    .btn-secondary:hover {
      background-color: #D6D6D6;
    }
  </style>
</head>
<body>
<!-- 프로젝트 생성 모달 -->
<div class="modal fade" id="createProjectModal" tabindex="-1" aria-labelledby="createProjectModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="createProjectModalLabel">프로젝트 생성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form class="modal-form" id="createProjectForm">
          <div class="mb-3">
            <label for="projectName" class="form-label">프로젝트 이름</label>
            <input type="text" class="form-control" id="projectName" placeholder="프로젝트 이름을 입력하세요" required>
          </div>
          <div class="mb-3">
            <label for="projectKey" class="form-label">프로젝트 키</label>
            <input type="text" class="form-control" id="projectKey" placeholder="예: PROJ" maxlength="10" required>
          </div>
          <div class="mb-3">
            <label for="projectLead" class="form-label">프로젝트 리드</label>
            <input type="text" class="form-control" id="projectLead" placeholder="프로젝트 리드의 이름을 입력하세요" required>
          </div>
          <div class="mb-3">
            <label for="projectDescription" class="form-label">프로젝트 설명</label>
            <textarea class="form-control" id="projectDescription" rows="10" placeholder="프로젝트에 대한 설명을 입력하세요"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="createProjectButton">생성</button>
      </div>
    </div>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    const createProjectButton = document.getElementById('createProjectButton');
    const createProjectForm = document.getElementById('createProjectForm');

    // 프로젝트 생성 버튼 클릭 이벤트
    createProjectButton.addEventListener('click', () => {
      const projectName = document.getElementById('projectName').value.trim();
      const projectKey = document.getElementById('projectKey').value.trim();
      const projectLead = document.getElementById('projectLead').value.trim();
      const projectDescription = document.getElementById('projectDescription').value.trim();

      if (!projectName || !projectKey || !projectLead) {
        alert('필수 입력 필드를 모두 채워주세요!');
        return;
      }

      // AJAX 요청
      fetch('/api/projects', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          name: projectName,
          key: projectKey,
          lead: projectLead,
          description: projectDescription,
        })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('프로젝트 생성에 실패했습니다.');
        }
        return response.json();
      })
      .then(data => {
        alert('프로젝트가 성공적으로 생성되었습니다.');
        // 모달 닫기
        const modal = bootstrap.Modal.getInstance(document.getElementById('createProjectModal'));
        modal.hide();

        // 폼 리셋
        createProjectForm.reset();

        // 페이지를 새로고침하거나 프로젝트 목록을 동적으로 업데이트
        location.reload();
      })
      .catch(error => {
        console.error('Error:', error);
        alert('프로젝트 생성 중 오류가 발생했습니다. 다시 시도해주세요.');
      });
    });
  });
</script>

</body>
</html>
