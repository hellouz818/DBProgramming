<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<html>
<head>
<title></title>
<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	Connection myConn = null;
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "db1812198";
	String passwd = "oracle";
	
	Statement stmt = null;	
	String mySQL = null;	
	ResultSet rs = null; 	
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
%>
</head>
<body>
<%
	try{
		Class.forName(dbdriver); //jdbc 드라이버 로딩
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement(); 
		mySQL = "select s_id, s_pwd from students where s_id='" + userID + "' and s_pwd='"+ userPassword +"'";
		rs = stmt.executeQuery(mySQL);
		
	}catch(ClassNotFoundException e){
		System.out.println("jdbc driver 로딩 실패");
		System.out.println(e);
	}catch(SQLException e){
		System.out.println("오라클 연결 실패");
	    System.out.println(e);
	    e.printStackTrace();
	}finally{
		if(rs != null){
			if (rs.next()) {
			session.setAttribute("user", userID);
%>
				<script> 
					alert("로그인 성공!"); 
					location.href="main.jsp";  
				</script>
<%
			}
			
			else {
%>
				<script> 
					alert("아이디/패스워드를 확인하세요."); 
					location.href="login.jsp";  
				</script>  
<%
			}
		}	
		stmt.close(); 
		myConn.close();
	}
%>
</body>
</html>