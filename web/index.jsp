<%--
  Created by IntelliJ IDEA.
  User: 33826
  Date: 2019/5/12
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  $END$
  </body>
</html>
<%

    session.setAttribute("unit_db_name","agriculture");
    //session.setAttribute("user_role","manager");
    //session.setAttribute("user_id","zhangsan");老师所认为的用户名，毕竟在所有表里都有，但是一个用户智能操作它添加的信息
%>
<script>
    window.location.href="home/login.jsp";
</script>
