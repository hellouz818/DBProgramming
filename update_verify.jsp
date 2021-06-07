<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head><title> 수강신청 사용자 정보 수정 </title>
<% 
request.setCharacterEncoding("utf-8");
String dbdriver = "oracle.jdbc.driver.OracleDriver";
Class.forName(dbdriver);
Connection myConn = null;

String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "db1914062"; //각자 오라클 계정 쓰십시오
String passwd = "oracle";

PreparedStatement stmt = null;
String mySQL = null;
//ResultSet rs = null;

//String VuserName=request.getParameter("VuserName");
String VuserID=request.getParameter("VuserID");
String VuserPassword=request.getParameter("VuserPassword");
String VuserPasswordC=request.getParameter("VuserPasswordC");
//pstmt.executeUpdate()
/*if(VuserID==null){
	VuserID=request.getParameter("VuserID");
}*/
System.out.println(VuserID+"    "+VuserPassword+"       "+VuserPasswordC);	

%>
</head>
<body>
<%

if(VuserPassword.equals(VuserPasswordC)==false){
	%><script>
	alert("비밀번호가 동일하지 않습니다.");
	location.href="update.jsp";
	</script><%
}
else{
	String str="";
	try{
		
		myConn = DriverManager.getConnection(dburl, user, passwd);
		mySQL="UPDATE student SET s_pwd=? WHERE s_id=?";
		stmt=myConn.prepareStatement(mySQL);
		stmt.setString(1,VuserPassword);
		//stmt.setString(2,VuserName);
		stmt.setString(2,VuserID);
		
		stmt.executeUpdate();
		
		%><script>
		alert("비밀번호가 바뀌었습니다.");
		location.href="main.jsp";
		</script><%
		
		

} catch(SQLException ex) {
	String sMessage;
	if (ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다";
	else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
	else sMessage="잠시 후 다시 시도하십시오";
	out.println("<script>");
	out.println("alert('"+sMessage+"');");
	out.println("location.href='update.jsp';");
	out.println("</script>");
	out.flush();//??????????????????? 
	}
finally{
	if(stmt!=null)try{stmt.close();}catch(SQLException sqle){}
	if(myConn !=null )try{myConn.close();}catch(SQLException sqle){}
	
}}
%>
</body></html>
