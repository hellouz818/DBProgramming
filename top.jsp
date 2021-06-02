<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String session_id = (String) session.getAttribute("user");
String log;
if (session_id == null)
log = "<a class='top_a' href=login.jsp>로그인</a>";
else log = "<a class='top_a' href=logout.jsp>로그아웃</a>"; %>
<link rel='stylesheet' href='./design.css' />
<table id="top_nav" width="75%" align="center">
<tr>
<td class="top_td" align="center"><b><%=log%></b></td>
<td class="top_td" align="center"><b><a class="top_a" href="update.jsp">사용자 정보 수정</b></td>
<td class="top_td" align="center"><b><a class="top_a" href="insert.jsp">수강신청 입력</b></td>
<td class="top_td" align="center"><b><a class="top_a" href="delete.jsp">수강신청 삭제</b></td>
<td class="top_td" align="center"><b><a class="top_a" href="select.jsp">수강신청 조회</b></td>
</tr>
</table>