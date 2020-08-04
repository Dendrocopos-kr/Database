
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="kr.co.dendrocopos.*"%>
<%
	String msg = "";
String suc = request.getParameter("suc");
try {
	if (suc != null) {
		switch (suc) {
	case "true" :
		msg = "수정 되었습니다.";
		break;
	case "false" :
		msg = "DB애러발생";
		break;
		}
	}
} catch (Exception e) {
}
%>
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
String strI_board = request.getParameter("id_board");
if (strI_board == null) {
%>
<script>
		alert('잘 못 된 접근입니다.');
		location.href='boardlist.jsp';
	</script>
<%
	return;
}
String name = "";
int id_board = 0;
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
if (board.getTitle() == null) {
%>

<script type="text/javascript">
alert('없는 페이지입니다.');
location.href = 'boardlist.jsp';
</script>
<%
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=board.getTitle()%></title>
</head>
<style>
.main_body {
	width: 800px;
	margin: 0 auto;
	display: flex;
}
.main_body div{
	margin: 10px;
}

.ctnt {
	border: black 1px solid;
	height: 400px;
	padding: 10px;
}

.board_ctnt_title {
	border: black 1px solid;
	display: flex;
	margin-bottom: 30px;
}

.board_ctnt_title div {
	margin: 10px;
}
</style>
<body>
	<div class="main_body">
		<div>
			<h3><%=msg%></h3>
			<div>
				<a href="/jsp/boardlist.jsp">리스트보기</a>
			</div>
			<div>
				<a href="#" onclick="procDel(<%=id_board%>)">삭제</a>
			</div>
			<div>
				<a href="/jsp/boardMod.jsp?id_board=<%=strI_board%>">수정</a>
			</div>
		</div>
		<div>
			<div class="board_ctnt_title">
				<!-- 
			<div>
				상세페이지 :
				<%=strI_board%></div>
				 -->
				<div>
					게시글 번호 :
					<%=strI_board%></div>
				<div>
					제목 :
					<%=board.getTitle()%></div>
				<div>
					작성일 :
					<%=board.getR_dt()%></div>
				<div>
					작성자 :
					<%=board.getId_student()%></div>
			</div>
			<div class="ctnt"><%=board.getCtnt()%></div>
		</div>
	</div>
	<script type="text/javascript">
	function procDel(id_board){
		var result = confirm('삭제하시겠습니까?');
		//alert('id_board :'+ id_board)
		if(result){
			location.href = '/jsp/boardDel.jsp?id_board='+id_board;
		}
	}</script>
</body>
</html>