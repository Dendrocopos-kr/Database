<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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
int curIndex = 0;
String sql = "insert into t_board (id_board,title,ctnt,id_student) select nvl(max(id_board),0)+1,?,?,? from t_board";

String title = request.getParameter("title");
String ctnt = request.getParameter("ctnt");
String name = request.getParameter("name");
//sql = " select ID_STUDENT,title,ctnt,r_dt from t_board where ID_BOARD=?";

try {
	conn = getConn();
	ps = conn.prepareStatement(sql);
	// (?순서 , value)
	ps.setNString(1, title);
	ps.setNString(2, ctnt);
	ps.setNString(3, name);
	//ps.setString(1	, String) // (?순서, String)
	ps.executeUpdate();
	//select => executeQuery();
	//그 외는 다른거
	//board.setId_board(rs.getInt("ID_BOARD"));
	sql = " select nvl(max(id_board),0) as curIndex from t_board ";
	ps = conn.prepareStatement(sql);
	rs = ps.executeQuery();
	while(rs.next()){
		curIndex = rs.getInt("curIndex");
	}

} catch (Exception e) {
	e.printStackTrace();
} finally {
	if(rs != null){
		try{
			rs.close();
		}catch(Exception e){}
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
response.sendRedirect("/jsp/boardDetail.jsp?id_board="+curIndex);
%>