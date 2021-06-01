
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
<title>수강신청 조회</title>
<link rel='stylesheet' href='./design.css' />

<script>
function local(){
	var fr=document.getElementById("FRM");
	var year=fr.year.value;
	var semester=fr.semester.value;
	
	//alert("local함수 year="+year+",semester="+semester);
	
	location.href="select.jsp?year="+year+"&semester="+semester;
	
}
</script
>
</head>
<body>
<%
//System.out.println(session_id);
Connection myConn = null;      
CallableStatement stmt = null;	
Statement STMT=null;
Statement stmt1=null;
Statement stmt2=null;
ResultSet myResultSet = null;
ResultSet rs=null;
ResultSet RS=null;
String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="db1912056";
String password="ss2";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

int year=0;//폼으로 받아오는 년도
int semester=0;//폼으로 받아오는 학기
int now_year=0;//sql 함수로 받는 year
int now_semester=0;//sql 함수로 받는 semester
int s_year=0;//입학년도!

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
	year=0;
	semester=0;
}

String sql="{?=call Date2EnrollYear(SYSDATE)}";
stmt=myConn.prepareCall(sql);
stmt.registerOutParameter(1,java.sql.Types.INTEGER);
stmt.execute();
now_year=stmt.getInt(1);

sql="{?=call Date2EnrollSemester(SYSDATE)}";
stmt=myConn.prepareCall(sql);
stmt.registerOutParameter(1,java.sql.Types.INTEGER);
stmt.execute();
now_semester=stmt.getInt(1);

System.out.println("현재날짜에 기반한 수강신청예정 년:"+now_year+"   학기 :"+now_semester);

stmt1=myConn.createStatement();
mySQL = "select s_year from student where s_id='" + session_id +"'";
rs=stmt1.executeQuery(mySQL);
while(rs.next()){
	s_year =rs.getInt("s_year");
}



if(s_year>now_year){
	%>
	<script>
	alert("입학년도가 현재보다 뒤입니다. 미래에서 오셨나요?");
	</script>
	<%
}

System.out.println("현재날짜에 기반한 수강신청예정 년:"+now_year+"   월 :"+now_semester+", 입학날짜 : "+s_year);//////


if(year==0 && semester==0){
	year=now_year;//폼에서 입력값없을땐, 즉 기본값은 현재 년도
	semester=now_semester;//다음 학기
}



%>
<h4 id="select_title" align="center"><%=year %>년도 <%=semester %>학기 수강신청 조회</h4>

<form id="FRM" method="POST" action="select.jsp" width="75%" align="center">
<select align="center" name="year" size="1">
<%
for(int i=now_year;i>=s_year;i--){
	%>
	<option value="<%=i%>"><%=i%>년</option>
	<%
}
%> 
</select>

<span align="right">
<select align="center" name="semester" size="1">
<%
if(semester==1){
	%>
	<option value="1" >1학기</option>
	<option value="2" >2학기</option>
	<%
}else{
	%>
	<option value="2">2학기</option>
	<option value="1">1학기</option>
	<%
}//수강신청 날짜 선택함
%>
</select></span>
<span align="right"><input type="submit" value="조회" onclick="local()"/></span>
</form>

<table class="enroll_tb" width="75%" align="center" border>
<tr><th class="enroll_th">교시</th><th class="enroll_th">과목번호</th><th class="enroll_th">과목명</th><th class="enroll_th">분반</th><th class="enroll_th">학점</th><th class="enroll_th">장소</th></tr>
<%
STMT=myConn.createStatement();
mySQL="select t_time, c_no, c_name, split_no, c_grade, place from teach where c_no in(select c_no from enroll where s_id='"+session_id+"' and year='"+year+"' and semester='"+semester+"')";
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
	</tr>
	<%
	}
}
else{
	%><h6>총 0 과목, 0 학점을 신청하였습니다.</h6><% 
}

%>

</table>

<%
//총 몇과목 몇학점인지 뷰로 나타내기
int sum_course=0;
int sum_grade=0;
stmt2=myConn.createStatement();

mySQL="CREATE OR REPLACE VIEW Finally_Sum as select c_no, c_grade from teach where c_no in (select c_no from enroll where s_id='"+session_id+"' and year='"+year+"' and semester='"+semester+"')";
stmt2.execute(mySQL);
mySQL="select count(*), sum(c_grade) from Finally_Sum";
RS=stmt2.executeQuery(mySQL);
while(RS.next()){
	sum_course=RS.getInt("count(*)");
	sum_grade=RS.getInt("sum(c_grade)");
}



%>
<h6>총 <%=sum_course %> 과목, <%=sum_grade %> 학점을 신청하였습니다.</h6>
<%
try{
	stmt.close();
	myConn.close();
}catch(Exception ex){
	
}
%>
</body>
</html>
