<%@ page language="java" contentType="text/html;
charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8"> <title>수강신청 시스템 로그인</title>
<link rel='stylesheet' href='./design.css'/>
</head>
<body>
<table id="login_th" width="75%" align="center">
<tr> <td class="login_td"><div align="center">아이디와 패스워드를 입력하세요
</div></td></table>
<table id="login_tb" width="75%" align="center" border>
<form method="post" action="login_verify.jsp">
<tr>
<td class="login_td"><div align="center">아이디</div></td>
<td class="login_td"><div align="center">
<input type="text" name="userID">
</div></td>
</tr>
<tr>
<td class="login_td"><div class="form_div" align="center">패스워드</div></td>
<td class="login_td"><div align="center">
<input type="password" name="userPassword">
</div></td></tr>
<tr>
<td class="login_td" colspan=2><div align="center">
<INPUT id="btn" TYPE="SUBMIT" NAME="Submit" VALUE="로그인">
<INPUT  id="btn" TYPE="RESET" VALUE="취소">
</div></td></tr>
</form>
</table>
</body>
</html>
