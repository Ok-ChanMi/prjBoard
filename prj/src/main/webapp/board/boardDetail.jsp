<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
.contents{
	width: 96%;
    height: 200px; /* 높이 조정 */
    padding: 10px;
    border: 1px solid #dddddd;
    border-radius: 5px;

}

td button,
td input {
    display: inline-block;
    margin-right: 5px; /* 버튼 간의 여백 조정 */
}

.file {
    background-color: #FFFFFF; /* 파일 선택 버튼 색상 */
    
}

.list {
    background-color: #595959; /* 목록 버튼 색상 */
    color: white;
    border: none;
    padding: 10px 15px;
    cursor: pointer;
    margin: 5px;
    border-radius: 5px;
}

.save {
    background-color: #508ED9; /* 수정 버튼 색상 */
    color: white;
    border: none;
    padding: 10px 15px;
    cursor: pointer;
    margin: 5px;
    border-radius: 5px;
}

.cancel {
    background-color: #F8F9FA; /* 삭제 버튼 색상 */
    color: black;
    border: 1px solid #cccccc;
    padding: 10px 15px;
    cursor: pointer;
    margin: 5px;
    border-radius: 5px;
}

.answer {
    background-color: #31859C; /* 답변 등록 버튼 색상 */
    color: white;
    border: none;
    padding: 10px 15px;
    cursor: pointer;
    margin: 5px;
    border-radius: 5px;
}

button:hover {
    opacity: 0.9;
}

textarea {
    width: 96%;
    height: 150px; /* 높이 조정 */
    padding: 10px;
    border: 1px solid #dddddd;
    border-radius: 5px;
}

input[type="text"], input[type="password"] {
    width: 100px; /* 비밀번호 입력 칸 너비 조정 */
    padding: 10px;
    border: 1px solid #dddddd;
    border-radius: 5px;
}

.align-right {
    text-align: right; /* 오른쪽 정렬 */
}
</style>
<script>
function fn_cancel() {
    var password = $("input[name='userPwd']").val(); // 비밀번호 입력 필드에서 값 가져오기
    var idx = ${boardVO.idx}; // 게시물 ID 가져오기

    if (confirm("정말로 삭제하시겠습니까?")) {
	    $.ajax({
	        type: "POST",
	        url: "boardDelete.do",
	        data: { userPwd: password, idx: idx },
	        dataType: "text",
	        success: function(result) {
	            if (result == 1) {
	                location.href = 'boardList.do';
	            } else if (result == -1) {
	                alert("암호가 일치하지 않습니다.");
	            } else {
	                alert("삭제 실패\n 관리자에게 연락주세요.");
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
	<table>
		<caption>게시판조회</caption>
		<tr>
			<td colspan="6">${boardVO.title }</td>
		</tr> 
		<tr>	
			<th>등록자</th>
			<td>${boardVO.author }</td>
			<th>등록일</th>
			<td>${boardVO.indate }</td>
			<th>조회수</th>
			<td>${boardVO.viewCount }</td>			
		</tr>
		<tr class="contents">
			<td colspan="6">${boardVO.contents }</td>
		</tr>
		<tr>
			<td>첨부파일</td> 
			<td colspan="6">
				<c:if test="${not empty fileDetails}">
    <ul>
        <c:forEach var="fileDetail" items="${fileDetails}">
            <li>
                <a href="<c:url value='fileDownload.do?fileName=${fileDetail.name}&uploadFile=${fileDetail.path}'/>">
                    ${fileDetail.name}
                </a>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty fileDetails}">
    <p>첨부파일이 없습니다.</p>
</c:if>

			</td>
							 
		</tr>
		<tr>
			<td colspan="6" >
			<button type="button" class="list" onclick="location='boardList.do'">목록</button>
			<input type="password" class="pass"placeholder="비밀번호" name="userPwd" value="${boardVO.userPwd }">
			<button type="button" class="save"onclick="location='boardModifyWrite.do?idx=${boardVO.idx }'">수정</button>
			<button type="button" class="cancel"onclick="fn_cancel(); return false;">삭제</button>
			<button type="button" class="answer">답변등록</button>
			</td>
		</tr>
	</table>
</body>
</html>