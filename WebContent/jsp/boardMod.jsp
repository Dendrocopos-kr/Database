<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="kr.co.dendrocopos.*"%>
<%!//전역으로 설정
	private Connection getConn() throws Exception {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String userName = "hr";
		String password = "koreait2020";

		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection Conn = DriverManager.getConnection(url, userName, password);
		System.out.println("접속성공");
		return Conn;
	}%>
<%
	Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
int id_board = 0;
String strI_board = request.getParameter("id_board");
T_boardVO board = new T_boardVO();

String sql = " select ID_STUDENT,title,ctnt,r_dt from t_board where ID_BOARD=?";

//sql = " SELECT  a.ID_STUDENT , title, ctnt, r_dt, nm FROM t_board a JOIN t_student b ON a.id_student = b.id_student WHERE id_board = ?";

//sql = " select ID_STUDENT,title,ctnt,r_dt from t_board where ID_BOARD=?";

try {
	conn = getConn();
	id_board = Integer.parseInt(strI_board);
	ps = conn.prepareStatement(sql);
	// (?순서 , value)
	ps.setInt(1, id_board);
	//ps.setString(1	, String) // (?순서, String)
	rs = ps.executeQuery();
	//select => executeQuery();
	//그 외는 다른거
	//board.setId_board(rs.getInt("ID_BOARD"));
	while (rs.next()) {
		board.setId_student(rs.getInt("ID_STUDENT"));
		board.setR_dt(rs.getNString("R_DT"));
		board.setTitle(rs.getNString("TITLE"));
		board.setCtnt(rs.getNString("CTNT"));
		//board.setId_student(rs.getInt("id_student"));
		//name = rs.getNString("nm");
	}

} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (rs != null)
		try {
	rs.close();
		} catch (Exception e) {
		}
	if (ps != null)
		try {
	ps.close();
		} catch (Exception e) {
		}
	if (conn != null)
		try {
	conn.close();
		} catch (Exception e) {
		}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
<style type="text/css">
.container {
	width: 600px;
	margin: 30px auto;
	border: 1px black solid;
	padding: 10px;
	display: flex;
	flex-direction: column;
}

form {
	display: flex;
	flex-direction: column;
}

form div {
	margin: 10px auto;
	display: flex;
}

div label {
	width: 100px;
}

div textarea, div input {
	width: 350px;
	margin-bottom: 30px;
}

.button {
	display: flex;
	justify-content: space-between;
}

.button input, .button button {
	width: 100px;
	margin: 50px;
}

div textarea {
	height: 400px;
}
</style>
</head>
<body>
	<div class="container">
		<form action="/jsp/boardModProc.jsp" method="post" onsubmit="return chk()" id="frm">
			<input type="hidden" name="id_board" value="<%=strI_board%>">
			<div>
				<label for="title">제목:</label><input id="title" name="title" value="<%=board.getTitle()%>">
			</div>
			<div>
				<label for="ctnt">내용:</label>
				<textarea id="ctnt" name="ctnt"><%=board.getCtnt()%></textarea>
			</div>
			<div>
				<label for="id">작성자:</label><input id="name" name="name" value="<%=board.getId_student()%>">
			</div>
			<div class="button">
				<input type="submit" value="글수정">
				<button id="ssibakl">돌아가기</button>
			</div>
		</form>

	</div>
	<script type="text/javascript">
	let temp = document.querySelector(`#ssibakl`);
	   temp.addEventListener("click", test);

	   function test(event) {
	      event.preventDefault();
	      location.href="/jsp/boardDetail.jsp?id_board=<%=id_board%>";
		}

		function eleValid(ele, nm) {
			if (ele.value.length == 0) {
				alert(nm + '을(를) 입력해주세요');
				ele.focus();
				return true;
			}
		}
		function chk() {
			if (eleValid(frm.title, '제목')) {
				return false;
			} else if (eleValid(frm.ctnt, '내용')) {
				return false;
			} else if (eleValid(frm.name, '이름')) {
				return false;
			}
		}
	</script>
</body>
</html>