<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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

String sql = " select id_board,title,r_dt from t_board order by id_board desc";

List<T_boardVO> boardList = new ArrayList<T_boardVO>();

try {
	conn = getConn();
	ps = conn.prepareStatement(sql);
	rs = ps.executeQuery();
	//select => executeQuery();
	//그 외는 다른거
	T_boardVO board;
	while (rs.next()) {
		board = new T_boardVO();
		board.setId_board(rs.getInt("ID_BOARD"));
		//board.setId_student(rs.getInt("ID_STUDENT"));
		board.setR_dt(rs.getString("R_DT"));
		board.setTitle(rs.getNString("TITLE"));
		//board.setCtnt(rs.getString("CTNT"));

		boardList.add(board);
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
<title>게시판</title>
</head>
<style>
table {
	border: black 1px solid;
	margin: 10px auto;
	border-collapse: collapse;
}

th, td {
	padding: 1em;
	border: black 1px solid;
	text-align: center;
}
td:nth-child(2){
	text-align: left;
}

div {
	text-align: center;
}
</style>
<body>
	<div>
		게시판 리스트 <a href="boardWrite.jsp">
			<button>글쓰기</button>
		</a>
	</div>
	<table>
		<tr>
			<th style="width:60px;">번호</th>
			<th style="width:300px;">제목</th>
			<th style="width:150px;">작성일</th>
		</tr>
		<%
			for (T_boardVO vo : boardList) {
		%>
		<tr>
			<td><%=vo.getId_board()%></td>
			<td>
				<a href="/jsp/boardDetail.jsp?id_board=<%=vo.getId_board()%>"> <%=vo.getTitle()%>
				</a>
			</td>
			<td>
			<%=vo.getR_dt() %>
			</td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>