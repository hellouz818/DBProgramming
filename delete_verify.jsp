<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<title>수강신청 삭제</title>

</head>
<body>

<%
	Connection myConn = null;    String	result = null;	
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user="db1914062";
	String passwd="oracle";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	CallableStatement cstmt=null;
	try {
		Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl,user,passwd);
	} catch(SQLException ex) {
    	 System.err.println("SQLException: " + ex.getMessage());
	}
	
	String session_id = (String)session.getAttribute("user");
	int split_no = Integer.parseInt(request.getParameter("split_no"));		
	String c_no = request.getParameter("c_no");		
	cstmt = myConn.prepareCall("{call DeleteEnroll(?,?,?,?)}");
	cstmt.setString(1, session_id);
	cstmt.setInt(2, split_no);
	cstmt.setString(3,c_no);
	cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);	
	try  {  	
			cstmt.execute();
			result = cstmt.getString(4);		
%>
	<script>	
	    alert("<%= result %>"); 
		location.href="delete.jsp";
	</script>
<%		
		} catch(SQLException ex) {		
			 System.err.println("SQLException: " + ex.getMessage());
		}  
		finally {
		    if (cstmt != null) 
	            try { myConn.commit(); cstmt.close();  myConn.close(); }
	 	      catch(SQLException ex) { }
	     }
%>
</form></body></html>
