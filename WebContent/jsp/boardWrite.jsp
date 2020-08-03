<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = "";
String err = request.getParameter("err");
try{
	int iErr = Integer.parseInt(err);
	if(iErr != 0){
		switch(iErr){
		case 10:
			msg = "등록할 수 없습니다.";
			break;
		case 20:
			msg = "DB애러발생";
			break;
		}
	}
}catch(Exception e){}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
<div><%=msg %></div>
	<div>
		<form action="/jsp/boardWriteProc.jsp" method="post" onsubmit="return chk()">
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
	<script type="text/javascript">
		function eleValid(ele,nm){
			if(ele.value.length == 0){
				alert(nm+'을(를) 입력해주세요');
				ele.focus();
				return true;
			}
		}
		function chk(){
			if(!eleValid(frm.title,'제목')){
				return false;
			}else if(!eleValid(frm.ctnt,'내용')){
				return false;
			}else if(!eleValid(frm.name,'이름')){
				return false;				
			}
		}
		/*
		function chk(){
			console.log(`title : \${frm.title.value}`);
			if(frm.title.value == ''){
				alet('제목을 입력해주세요.');
				frm.title.focus();
				return false;
			}
			if(frm.ctnt.value.length == 0){
				alet('내용을 입력해주세요.');
				frm.title.focus();
				return false;
			}
			if(frm.name.value == ''){
				alet('작성자를 입력해주세요.');
				frm.title.focus();
				return false;
			}
		}
		*/
	</script>
</body>
</html>