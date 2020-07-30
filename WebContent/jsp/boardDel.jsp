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
int rs = -1;

String strI_board = request.getParameter("id_board");
if(strI_board == null){
	%>
	<script>
		alert('잘 못 된 접근입니다.');
		location.href='boardlist.jsp';
	</script>
	<%
	return ;
}

int id_board = 0;
String sql = "delete from t_board where id_board =? ";

try {
	conn = getConn();
	id_board = Integer.parseInt(strI_board);
	ps = conn.prepareStatement(sql);
	ps.setInt(1, id_board);
	rs = ps.executeUpdate();
}catch(NumberFormatException e){
	
}catch(SQLIntegrityConstraintViolationException e){
	
}catch (Exception e) {
	e.printStackTrace();
} finally {
	if (ps != null)try {ps.close();} catch (Exception e) {}
	if (conn != null)try {conn.close();} catch (Exception e) {}
}

System.out.println("result : "+rs);
/*
switch(rs){
case -1:
	response.sendRedirect("/jsp/boardlist.jsp?err=-1&id_board="+id_board);
	break;
case 0:
	response.sendRedirect("/jsp/boardlist.jsp?err=0&id_board="+id_board);
	break;
case 1:
	response.sendRedirect("/jsp/boardlist.jsp");
	break;
}
*/
%>

	<script type="text/javascript">
	(function(){
		switch(<%=rs%>){
		case -1:
			alert('삭제에 실패했습니다. 다시확인해주세요.');
			location.href='/jsp/boardDetail.jsp?err=-1&id_board='+<%=id_board%>;
			break;
		case 0:
			alert('존재하지 않는 페이지거나 삭제된 페이지 입니다.\n 다시확인해주세요.');
			location.href='/jsp/boardlist.jsp';
			break;
		default:
			alert('데이터가 '+ <%=rs%> +'개 삭제되었습니다.');
			location.href='boardlist.jsp';
			break;
		}	
		/*
		var result = confirm('해당하는'+rs_int+'개를 삭제했습니다');
		if(result){
			location.href = '/jsp/boardlist.jsp';
			*/
			/*
			if( rs_int != -1 ){
				alert('데이터가 '+rs_int+'개 삭제되었습니다.');
				location.href='boardlist.jsp';
			}else{
				alert('삭제에 실패했습니다. 다시확인해주세요.');
				location.href='/jsp/boardDetail.jsp?i_board='+id_board;
			}
	*/
	}());
	</script>