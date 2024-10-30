<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 수정</title>
    <script src="/prj/script/jquery-3.7.1.js"></script>
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
function fn_submit() {
    if ($("#contents").val() == "") {
        alert("내용을 입력해 주세요!");
        $("#contents").focus();
        return false;
    }
    $("#contents").val($.trim($("#contents").val()));

    var formData = new FormData($("#modifyBoardForm")[0]); // FormData에 폼 데이터 추가

    // 주소, 전송타입, 전송데이터, url, 리턴, 성공,실패시
    $.ajax({
        type: "POST",
        data: formData,
        url: "boardModifySave.do",
        processData : false,
		contentType : false,
        dataType: "text",   // 리턴타입
        success: function(data) {
            if (data == "ok") {    // 컨트롤러에서 값을 받아온거
                alert("저장을 완료했습니다.");
                location.href = 'boardDetail.do?idx=' + $('#modifyBoardForm input[name="idx"]').val(); // 수정된 게시물의 상세 페이지로 이동
            } else {
                alert("저장에 실패했습니다.");
            }
        },
        error: function() {    // 시스템에러(장애발생)
            alert("오류발생");
        }
    });
}
function deleteFile(fileName, filePath) {
    if (confirm("정말 삭제하시겠습니까?")) {
        // 파일 삭제 요청을 위해 filesToDelete에 추가
        if (!window.filesToDelete) {
            window.filesToDelete = [];
        }
        window.filesToDelete.push({ name: fileName, path: filePath });

        // FormData 객체 생성
        var formData = new FormData();
        window.filesToDelete.forEach(function(file) {
            formData.append("filesToDelete", file.name); // 파일 이름 추가
            formData.append("filePaths", file.path); // 파일 경로 추가
        });

        // URL에서 idx 값 가져오기
        const params = new URLSearchParams(window.location.search);
        const idx = params.get('idx'); // idx 값 가져오기
        // idx 추가
        formData.append("idx", idx); // idx 추가

        $.ajax({
            type: "POST",
            url: "boardModifySave.do", 
            data: formData,
            processData: false, 
            contentType: false, 
            success: function(result) {
                if (result === "ok") {
                    alert("파일이 삭제되었습니다.");
                    updateFileList(); // 파일 목록 업데이트
                } else {
                    alert("파일 삭제에 실패했습니다.");
                }
            },
            error: function() {
                alert("오류 발생");
            }
        });
    }
}


</script>

<body>
    <form id="modifyBoardForm" action="boardModifySave.do" enctype="multipart/form-data">
        <table>
            <caption>게시판 수정</caption>
            <tr>
                <th><label for="author">작성자</label><input type="hidden" name="idx" value="${boardVO.idx}"></th>
                <td><input type="text" name="author" value="${boardVO.author}" readonly="readonly"></td>
                <th><label for="userPwd">비밀번호</label></th>
                <td><input type="password" name="userPwd" value="${boardVO.userPwd}" readonly="readonly" placeholder="******"></td>
            </tr> 
            <tr>    
                <th><label for="title">제목</label></th>
                <td colspan="3"><input type="text" name="title" value="${boardVO.title}" readonly="readonly"></td>
            </tr>
            <tr>    
                <th><label for="contents">내용</label></th>
                <td colspan="3"><textarea name="contents" oninput="this.value = this.value.replace(/<[^>]*>/g, '');">${boardVO.contents}</textarea></td>
            </tr>
            <tr>    
                <th><label for="filename">첨부파일</label></th>
                   
                <td colspan="7">
                <c:if test="${not empty fileDetails}">
    <ul>
        <c:forEach var="fileDetail" items="${fileDetails}">
            <li>
                    ${fileDetail.name}
                    <a href="#" onclick="deleteFile('${fileDetail.name}', '${fn:replace(fileDetail.path, '\\', '/')}')">X</a>
            </li>
        </c:forEach>
    </ul>
</c:if>
                    
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