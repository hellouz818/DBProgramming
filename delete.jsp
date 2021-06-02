<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>


<%@ include file="top.jsp" %>
<%
if (session_id==null) response.sendRedirect("login.jsp");  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 취소</title>

<script>
function local(){
	var fr=document.getElementById("FRM");
	var year=fr.year.value;
	var semester=fr.semester.value;
	
	location.href="select.jsp?year="+year+"&semester="+semester;
	
}
</script>

</head>
<body>
<%
Connection myConn = null;      
CallableStatement stmt = null;	
Statement STMT=null;
ResultSet myResultSet = null;
String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="db1916205";
String password="oracle";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
int year;
int semester;
try{
	Class.forName(dbdriver);
	myConn=DriverManager.getConnection(dburl,user,password);
}catch(SQLException ex){
	System.err.println("SQLException: " + ex.getMessage());
}
try{
	String Y=request.getParameter("year");
	year=Integer.parseInt(Y);
	String M=request.getParameter("semester");
	semester=Integer.parseInt(M);
	System.out.println("selected year:"+year+"   selected semester :"+semester);
}catch(Exception e){
	String sql="{?=call Date2EnrollYear(SYSDATE)}";
	stmt=myConn.prepareCall(sql);
	stmt.registerOutParameter(1,java.sql.Types.INTEGER);
	stmt.execute();
	year=stmt.getInt(1);
	sql="{?=call Date2EnrollSemester(SYSDATE)}";
	stmt=myConn.prepareCall(sql);
	stmt.registerOutParameter(1,java.sql.Types.INTEGER);
	stmt.execute();
	semester=stmt.getInt(1);
	
	System.out.println("현재날짜에 기반한 수강신청예정 년:"+year+"   월 :"+semester);
}
%>
<h4 align="center"><%=year %>년도 <%=semester %>학기 수강신청 조회</h4>



<table width="75%" align="center" border>
<tr><th>교시</th><th>과목번호</th><th>과목명</th><th>분반</th><th>학점</th><th>장소</th><th>강의 삭제</th></tr>
<%
STMT=myConn.createStatement();
mySQL="select c_time, c_no, c_name, split_no, grade, place from course where c_no in(select c_no from enroll where s_id='"+session_id+"' and year='"+year+"' and semester='"+semester+"')";
myResultSet=STMT.executeQuery(mySQL);
if(myResultSet!=null){
	while(myResultSet.next()){
		int c_time =myResultSet.getInt("c_time");
		String c_no=myResultSet.getString("c_no");
		String c_name=myResultSet.getString("c_name");
		int split_no=myResultSet.getInt("split_no");
		int grade=myResultSet.getInt("grade");
		String place=myResultSet.getString("place");		
	
	%>
	<tr>
	<td align="center"><%=c_time%></td>
	<td align="center"><%=c_no%></td>
	<td align="center"><%=c_name%></td>
	<td align="center"><%=split_no%></td>
	<td align="center"><%=grade%></td>
	<td align="center"><%=place%></td>
	<td align="center"><a href="delete_verify.jsp?split_no=<%=split_no%>&c_no=<%= c_no%>">취소</a></td>
					
	</tr>
	<%
	}
}
try{
	stmt.close();
	myConn.close();
}catch(Exception ex){}
%>

</table>
</body>
</html>