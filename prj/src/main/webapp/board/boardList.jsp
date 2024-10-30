<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<style>
body {
    background-color: #FFFFFF; /* 밝은 회색 배경 */
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 100px;
}


h5 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    background-color: #fff; /* 테이블 배경 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
}

th, td {
    border: 1px solid #dee2e6; /* 연한 회색 테두리 */
    padding: 12px;
    text-align: left;
}

th {
    background-color: #F8FAFC; /* 헤더 색상 */
    color: #000000; /* 헤더 텍스트 색상 */
}
a {
    color: #000000; /* 링크 색상을 투명으로 */
}
.searchBtn {
	width: 80px;
    height: 35px;
    margin-top: 20px;
    border-radius: 5px;
    text-align: center;
    color: #FFFFFF;
    background-color: #92969C;
    display: block; /* 블록 요소로 변경 */
    margin: 0 auto; /* 자동 여백으로 가운데 정렬 */
}
caption {
    font-size: 1.5em;
    margin-bottom: 10px;
}

.box1{
	padding: 50px;
	margin: 5px;
	background-color: #F0F2F4;
}
.box2 {
    display: flex; /* Flexbox 사용 */
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: space-between; /* 요소들 사이의 공간을 균등 분배 */
    width: 100%; /* 부모 요소의 너비를 꽉 채움 */
    font-size: 1.2rem;
    padding: 10px; /* 여백 추가 (필요에 따라 조절) */
    background-color: #F0F2F4; /* 배경 색상 */
}

.box2 label {
    margin-right: 10px; /* 라벨과 요소 간 간격 조정 */
}

.box2 select,
.box2 input[type="text"] {
    flex: 1; /* 요소들이 공간을 균등하게 차지하도록 설정 */
    margin-right: 10px; /* 입력 필드 간 간격 조정 */
    font-size: inherit;
}

.box2 input[type="text"] {
    margin-right: 0; /* 마지막 입력 필드의 오른쪽 여백 제거 */
    font-size: inherit;
}

</style>
<body>
    <form name="SearchForm" action="boardList.do" method="get">
        <h5>게시판 리스트</h5>
          <div class="box1">
            <div class="box2">
            	<label for="SearchConditions" >검색조건</label>
            	<select name="SearchConditions" id="SearchConditions">
                        <option value="author">작성자</option>
                        <option value="title">제목</option>
                </select>
                <label for="SearchWord">검색어</label>
                <input type="text" name="SearchWord" id="SearchWord">
            </div>
            	<button type="submit" class="searchBtn">검색</button>
          </div>
          </form>  
            <div>전체 : ${total }건</div>
       <table>
            <tr>
                <th>순번</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
            <c:set var="cnt" value="${startRowNo }"/>
            
                <c:forEach var="board" items="${boardList }" varStatus="status">
                    <tr>
                        <td><c:out value="${cnt }"/></td>
                        <td><a href="boardDetail.do?idx=${board.idx }&nowPage=${nowPage}">${board.title }</a></td>
                        <td>${board.author }</td>
                        <td>${board.indate }</td>
                        <td>${board.viewCount }</td>
                    </tr>
                
                	<c:set var="cnt" value="${cnt-1 }"/>
                </c:forEach>
        </table>
        
        <div class="pagination">
		    <a href="boardList.do?viewPage=${firstPage}">&lt;&lt;</a>
		    <a href="boardList.do?viewPage=${prevPage}">&lt;</a>
		
		    <c:set var="startPage" value="${viewPage - 9 < 1 ? 1 : viewPage - 9}"/>
			<c:set var="endPage" value="${startPage + 9 > totalPage ? totalPage : startPage + 9}"/>
			
			<c:if test="${endPage > totalPage}">
			    <c:set var="endPage" value="${totalPage}"/>
			</c:if>
			
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
			    <a href="boardList.do?viewPage=${i}" 
			       style="${viewPage == i ? 'font-weight:bold;text-decoration: underline;' : ''}">${i}</a>
			</c:forEach>
		
		    <a href="boardList.do?viewPage=${nextPage}">&gt;</a>
		    <a href="boardList.do?viewPage=${lastPage}">&gt;&gt;</a>
		</div>
        
        <button type="button" onclick="location='boardWrite.jsp'">글쓰기</button>
    
</body>
</html>
