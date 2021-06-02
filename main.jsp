<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> <meta charset="EUC-KR">
<title>데이터베이스를 활용한 수강신청 시스템입니다.</title> </head>
<link rel='stylesheet' href='./design.css' />
<body>
<%@include file="top.jsp"%>
<table id="main_table" width="75%" align="center" height="100%">
<% if (session_id != null) { %>
<tr> <td align="center"><br><br><br><br><%=session_id%>님 방문을 환영합니다.</td> </tr>
<% } else { %>
<tr> <td align="center"><br><br><br><br>로그인한 후 사용하세요.</td> </tr>
<% } %>
</table> 
</body> 
</html>