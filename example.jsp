<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
String driver="oracle.jdbc.driver.OracleDriver";
String url="jdbc:oracle:thin:@localhost:1521:xe";
String user="db1914062";
String password="oracle";
try{
	Class.forName(driver);
	out.println("1914062 jdbc driver 연결 성공");
	DriverManager.getConnection(url,user,password);
	out.println("1914062 오라클 연결 성공");
}catch(ClassNotFoundException e){
	System.out.println("jdbc driver 로딩 실패");
}catch(SQLException e){
	System.out.println("오라클 연결 실패");
}

%>
</body>
</html>
	