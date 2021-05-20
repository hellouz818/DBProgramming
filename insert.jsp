<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"  %>
<html><head><title>수강신청 입력</title></head>
<body>
<%@ include file="top.jsp" %>
<%   if (session_id==null) response.sendRedirect("login.jsp");  %>

<table width="75%" align="center" border>
<br>
<tr><th>과목번호</th><th>분반</th><th>과목명</th><th>학점</th>
      <th>수강신청</th></tr>
<%
	Connection myConn = null;      Statement stmt = null;	
	ResultSet myResultSet = null;   String mySQL = "";
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user="db1916205";     String passwd="oracle";
     String dbdriver = "oracle.jdbc.driver.OracleDriver";    

	try {
		Class.forName(dbdriver);
	         myConn =  DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();	
    } catch(SQLException ex) {
	     System.err.println("SQLException: " + ex.getMessage());
    }
mySQL = "select c_no,split_no,c_name,grade from course where c_no not in (select c_no from enroll where s_id='" + session_id + "')";
	
myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null) {
	while (myResultSet.next()) {	
		String c_no = myResultSet.getString("c_no");  //과목번호
		int split_no = myResultSet.getInt("split_no");	//분반	
		String c_name = myResultSet.getString("c_name");  //과목명
		int grade = myResultSet.getInt("grade");	 //학점
%>
<tr>
  <td align="center"><%= c_no %></td> <td align="center"><%= split_no %></td> 
  <td align="center"><%= c_name %></td><td align="center"><%= grade %></td>
  <td align="center"><a href="insert_verify.jsp?c_no=<%= c_no %>&split_no=<%= split_no %>">신청</a></td>
</tr>
<%
		}
	}
	stmt.close();  myConn.close();
%>
</table></body></html>
    