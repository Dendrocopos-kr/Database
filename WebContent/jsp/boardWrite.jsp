<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
	<div>
		<form action="/jsp/boardWriteProc.jsp" method="post">
			<div>
				<label for="title">제목:</label><input id="title" name="title">
			</div>
			<div>
				<label for="ctnt">내용:</label><textarea id="ctnt" name="ctnt"></textarea>
			</div>
			<div>
				<label for="id">작성자:</label><input id="name" name="name">
			</div>
			<div>
				<input type="submit" value="글등록" id="" name="">
			</div>
		</form>
	</div>
</body>
</html>