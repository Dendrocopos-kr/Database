
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
	}
%>
<%
	String strI_board = request.getParameter("i_board");
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	T_boardVO board = new T_boardVO();
	String name ="";
	
	String sql = " select ID_STUDENT,title,ctnt,r_dt from t_board where ID_BOARD=" + strI_board;
	
	sql = " SELECT  a.ID_STUDENT , title, ctnt, r_dt, nm FROM t_board a JOIN t_student b ON a.id_student = b.id_student WHERE id_board = "+strI_board;
	
	try {
		conn = getConn();
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		//select => executeQuery();
		//그 외는 다른거
		//board.setId_board(rs.getInt("ID_BOARD"));
		while (rs.next()) {
			board.setId_student(rs.getInt("ID_STUDENT"));
			board.setR_dt(rs.getString("R_DT"));
			board.setTitle(rs.getNString("TITLE"));
			board.setCtnt(rs.getString("CTNT"));
			name = rs.getNString("nm");
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
<title>Insert title here</title>
</head>
<style>
.main_body {
	width: 800px;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
}

.ctnt {
	border: black 1px solid;
	height: 400px;
	padding: 10px;
}

.board_ctnt_title {
	border: black 1px solid;
	display: flex;
}
.board_ctnt_title div{
	margin: 20px;
}
</style>
<body>
	<div class = "main_body">
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
				<%=name%>%></div>
		</div>
		<div class="ctnt"><%=board.getCtnt()%></div>
	</div>
</body>
</html>