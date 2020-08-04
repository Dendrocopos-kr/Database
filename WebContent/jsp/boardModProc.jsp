<%@page import="java.io.Console"%>
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
int iName = -1;
int id_board = -1;
int result = -1;
String sql = " update t_board set title = ?, ctnt = ?, id_student = ? where id_board = ? ";

String title = request.getParameter("title");
String ctnt = request.getParameter("ctnt");
String name = request.getParameter("name");
String strI_board = request.getParameter("id_board");

//sql = " select ID_STUDENT,title,ctnt,r_dt from t_board where ID_BOARD=?";

if("".equals(title) || "".equals(ctnt) || "".equals(name)){
	response.sendRedirect("/jsp/boardMod.jsp?err=10");
	return;
}


try {
	conn = getConn();
	ps = conn.prepareStatement(sql);
	// (?순서 , value)
	ps.setNString(1, title);
	ps.setNString(2, ctnt);
	try{
		iName = Integer.parseInt(name);
	}catch(Exception e){
	}
	try{
		id_board = Integer.parseInt(strI_board);
	}catch(Exception e){
	}
	ps.setInt(3, iName);
	ps.setInt(4,id_board);
	//ps.setString(1	, String) // (?순서, String)
	result = ps.executeUpdate();
	//select => executeQuery();
	//그 외는 다른거
	//board.setId_board(rs.getInt("ID_BOARD"));
	
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
int err = 0;
switch(result){
case -1:
	err = 20;
	break;
case 0:
	err = 10;
	break;
case 1:
	response.sendRedirect("/jsp/boardDetail.jsp?id_board="+id_board+"&suc=true");
	return;	
}
response.sendRedirect("/jsp/boardMod.jsp?err="+err);

//response.sendRedirect("/jsp/boardDetail.jsp?id_board="+curIndex);
return;
%>