<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
<script src="/prj/script/jquery-3.7.1.js"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>

</head>
<style>
 body {
        margin: 0;
        font-family: 'Arial', sans-serif;
        background-color: #ffffff;
        padding: 50px; /* 상하 여백 */
    }

    h5 {
        text-align: center;
        color: #333;
    }

    table {
        width: 800px;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
        border: 1px solid #dddddd;
        padding: 12px;
        text-align: left;
        background-color: #ffffff;
        color: #3C3630;
    }
    .save {
        background-color: #508ED9; /* 저장 버튼 색상 */
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        margin: 5px;
        border-radius: 5px;
    }

    .cancel {
        background-color: #F8F9FA; /* 취소 버튼 색상 */
        color: black;
        border: 1px solid #cccccc;
        padding: 10px 15px;
        cursor: pointer;
        margin: 5px;
        border-radius: 5px;
    }

    .save:hover {
        opacity: 0.9;
    }
    .cancel:hover {
        background-color: #E6E6E6;
        opacity: 0.9;
    }
    .button-container {
        text-align: right; /* 버튼을 오른쪽 정렬 */
    }

    textarea {
    	width: 96%;
        height: 150px; /* 높이 조정 */
        padding: 10px;
        border: 1px solid #dddddd;
        border-radius: 5px;
        resize: none; /* 크기 조정 비활성화 */
    }

    input[type="text"], input[type="password"] {
        width: calc(100% - 22px); /* 테두리와 패딩을 고려한 너비 */
        padding: 10px;
        border: 1px solid #dddddd;
        border-radius: 5px;
    }
</style>
<script>

function addEventListener() {
    const dropArea = document.getElementById('dropArea');
    const fileInput = document.getElementById('fileName');
    
    // 드래그 오버 이벤트 방지
    dropArea.addEventListener('dragover', (e) => {
        e.preventDefault();
        dropArea.style.borderColor = '#333'; // 드래그 오버 시 테두리 색상 변경
    });

    // 드래그가 끝났을 때
    dropArea.addEventListener('dragleave', () => {
        dropArea.style.borderColor = '#ccc'; // 테두리 색상 복원
    });

    // 드래그한 파일이 드롭될 때
    dropArea.addEventListener('drop', (e) => {
        e.preventDefault();
        dropArea.style.borderColor = '#ccc'; // 테두리 색상 복원
        
        const files = e.dataTransfer.files; // 드롭된 파일들
        fileInput.files = files; // 파일 입력에 드롭된 파일 추가
        updateFileList(); // 파일 목록 업데이트
    });

    // 드래그 앤 드롭 영역 클릭 시 파일 선택
    dropArea.addEventListener('click', () => {
        fileInput.click(); // 파일 선택 대화상자 열기
    });
}

document.addEventListener('DOMContentLoaded', addEventListener);



function updateFileList() {
    const input = document.getElementById('fileName');
    const fileList = document.getElementById('fileList');
    fileList.innerHTML = ''; // 기존 리스트 초기화

    for (const file of input.files) {
        const li = document.createElement('li');
        li.textContent = file.name; // 파일 이름 추가

        // 삭제 버튼 생성
        const deleteBtn = document.createElement('button');
        deleteBtn.textContent = '❌'; // 삭제 아이콘
        deleteBtn.classList.add('fileDelBtn'); // 클래스 추가
        deleteBtn.style.marginLeft = '10px'; // 여백 추가

        // 삭제 버튼 클릭 시 동작
        deleteBtn.addEventListener('click', function() {
            if (confirm("정말 삭제하시겠습니까?")) {
                li.remove(); // 해당 파일 항목 삭제
            }
        });

        li.appendChild(deleteBtn); // 삭제 버튼을 리스트 항목에 추가
        fileList.appendChild(li); // 리스트에 항목 추가
    }
}

function fn_submit() {
	
	if( $("#author").val() == "" ){
		alert("작성자를 입력해 주세요!");
		$("#author").focus();
		return false;
	}
	$("#author").val($.trim($("#author").val()));
	
	if( $("#userPwd").val() == "" ){
		alert("비밀번호를 입력해 주세요!");
		$("#userPwd").focus();
		return false;
	}
	$("#userPwd").val($.trim($("#userPwd").val()));
	
	if( $("#title").val() == "" ){
		alert("제목을 입력해 주세요!");
		$("#title").focus();
		return false;
	}
	$("#title").val($.trim($("#title").val()));
	
	if( $("#contents").val() == "" ){
		alert("내용을 입력해 주세요!");
		$("#contents").focus();
		return false;
	}
	$("#contents").val($.trim($("#contents").val()));
	
	

	
	var formData = (new FormData($("#boardForm")[0])); // FormData에 폼 데이터 추가
	
	// 주소, 전송타입, 전송데이터, url, 리턴, 성공,실패시
	$.ajax({ 
        type: "POST",
        url: "boardWriteSave.do",
        processData : false,
		contentType : false,
        data: formData,
        success: function(data) {
            if (data == "ok") {
                alert("저장을 완료했습니다.");
                location = "boardList.do";
            } else {
                alert("저장에 실패했습니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 오류:", xhr.responseText);
            alert("오류 발생: " + xhr.responseText);
        }
    });
	
}

</script>
<body>
	<form id="boardForm" action="boardWriteSave.do" method="post" encType="multipart/form-data">
	<table>
		<caption>게시판등록</caption>
		<tr>
			<th><label for="author">작성자</label></th>
			<td><input type="text" name="author" id="author"></td>
		
			<th><label for="userPwd">비밀번호</label></th>
			<td><input type="password" name="userPwd" id="userPwd"></td>
		</tr> 
		<tr>	
			<th><label for="title">제목</label></th>
			<td colspan="3"><input type="text" name="title" id="title"></td>
		</tr>
		<tr>	
			<th><label for="contents">내용</label></th>
			<td colspan="3"><textarea name="contents" id="contents"></textarea></td>
		</tr>
		<tr>	
			<th>첨부파일</th>	
			<td colspan="4">
				<input type="file" name="file" id="fileName" accept=".jpg,.jpeg,.png,.gif,.pdf,.hwp" multiple onchange="updateFileList()">
					<ul id="fileList"></ul>
			</td>
		</tr>
		<tr>
			<th colspan="4" class="button-container">
			<button type="button" onclick="fn_submit(); return false;" class="save">저장</button>
			<button type="reset" class="cancel" onclick="history.back();">취소</button>
			</th>
		</tr>
	</table>
</form>
</body>
</html>