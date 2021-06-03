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
<h4 id="delete_title" align="center"><%=year %>년도 <%=semester %>학기 수강신청 조회</h4>



<table class="enroll_tb" width="75%" align="center" border>
<tr><th class="enroll_th">교시</th><th class="enroll_th">과목번호</th><th class="enroll_th">과목명</th><th class="enroll_th">분반</th><th class="enroll_th">학점</th><th class="enroll_th">장소</th><th class="enroll_th">강의 삭제</th></tr>
<%
STMT=myConn.createStatement();
mySQL="select teach.t_time, teach.c_no, teach.c_name, teach.split_no, teach.c_grade, teach.place from teach, enroll where teach.c_no=enroll.c_no and teach.split_no=enroll.split_no and t_year=year and t_semester=semester and s_id='"+session_id+"' and enroll.year='"+year+"' and enroll.semester='"+semester+"'";
myResultSet=STMT.executeQuery(mySQL);
if(myResultSet!=null){
	while(myResultSet.next()){
		int c_time =myResultSet.getInt("t_time");
		String c_no=myResultSet.getString("c_no");
		String c_name=myResultSet.getString("c_name");
		int split_no=myResultSet.getInt("split_no");
		int grade=myResultSet.getInt("c_grade");
		String place=myResultSet.getString("place");		
	
	%>
	<tr>
	<td class="enroll_td" align="center"><%=c_time%></td>
	<td class="enroll_td" align="center"><%=c_no%></td>
	<td class="enroll_td" align="center"><%=c_name%></td>
	<td class="enroll_td" align="center"><%=split_no%></td>
	<td class="enroll_td" align="center"><%=grade%></td>
	<td class="enroll_td" align="center"><%=place%></td>
	<td class="enroll_td" align="center"><a id="delete_btn" href="delete_verify.jsp?split_no=<%=split_no%>&c_no=<%= c_no%>">취소</a></td>
					
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
