<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="java.sql.*" %>

<html>
<head>
	<title>수강신청 사용자 정보 수정</title>
	<link rel='stylesheet' href='./design.css' />
</head>
<body>
<%@ include file="top.jsp" %>
<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	Connection myConn = null;

	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "db1914062";   //각자 오라클 계정
	String passwd = "oracle";
	
	

	Statement stmt = null;
	String mySQL = null;
	ResultSet result = null;
	//String VuserName=request.getParameter("userName");
 	String VuserID = session_id;
	String VuserPwd="";
%>
<%
	if (session_id == null) {%> 
		<script> 
			alert("로그인 후 사용하세요."); 
			location.href="login.jsp";  
		</script>

<%
	} else { 
		try{
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement(); 
			
			mySQL = "select s_pwd, s_id from student where s_id='" + VuserID + "'";
			result = stmt.executeQuery(mySQL);
			
		}catch(SQLException e){
		    out.println(e);
		    e.printStackTrace();
		}finally{
			if(result != null){
				if (result.next()) {
					VuserPwd = result.getString("s_pwd");
					VuserID=result.getString("s_id");
					//System.out.println(VuserID+"   "+VuserPwd);
				}
				else {
%>
					<script> 
						alert("세션이 종료되었습니다. 다시 로그인 해주세요."); 
						location.href="login.jsp";  
					</script>  
<%
				}
			}	
%>

<form method="post" action="update_verify.jsp?id=<%=session_id%>">
			<table align="center" id="update_table">
			<tr>
			  <td id="update_td">아이디</td>
			  <td colspan="3">
			  <input id="update_id_in" type="text" name="VuserID" size="50" style="text-align: center;" value=<%=VuserID%> readonly></td>
			</tr>
			<tr>  
			  <td id="update_td">비밀번호</td>
			  <td><input id="update_pw_in" type="password" name="VuserPassword" size="10" value=<%=VuserPwd%>></td>
			  <td id="update_td">확인</td>
			  <td><input id="update_pw_in" type="password" name="VuserPasswordC" size="10" ></td>
			</tr>
			<tr>
			  <td colspan="4" align="center">
			  <input id="btn" type="submit" value="수정 완료">
			  <input id="btn" type="reset" value="초기화">
			</tr>
			</table>
			</form>
<%
			stmt.close();
			myConn.close();
		}
	}
%>
</body>
</html>