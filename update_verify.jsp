<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<html>
<head><title> ������û ����� ���� ���� </title>
<% 
request.setCharacterEncoding("utf-8");
String dbdriver = "oracle.jdbc.driver.OracleDriver";
Class.forName(dbdriver);
Connection myConn = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "db1916205"; //���� ����Ŭ ���� ���ʽÿ�
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
	alert("��й�ȣ�� �������� �ʽ��ϴ�.");
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
		alert("��й�ȣ�� �ٲ�����ϴ�.");
		location.href="main.jsp";
		</script><%
		
		
} catch(SQLException ex) {
	String sMessage;
	if (ex.getErrorCode() == 20002) sMessage="��ȣ�� 4�ڸ� �̻��̾�� �մϴ�";
	else if (ex.getErrorCode() == 20003) sMessage="��ȣ�� ������ �Էµ��� �ʽ��ϴ�.";
	else sMessage="��� �� �ٽ� �õ��Ͻʽÿ�";
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