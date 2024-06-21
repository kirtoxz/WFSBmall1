<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/flat-ui.min.css"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/flat-ui.min.js"></script>
    <title>注册结果</title>
    <style type="text/css">
        body {
            background-image: url("image/background.png");
            background-size: cover;
        }
        .row {
            margin-left: 20px;
            margin-right: 20px;
        }
    </style>
    <script>
        function showAlert(message, redirectUrl) {
            alert(message);
            window.location.href = redirectUrl;
        }
    </script>
</head>
<body>
<%
    // 从request中获取表单数据
    request.setCharacterEncoding("utf-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String sex = request.getParameter("sex");
    String telephone = request.getParameter("telephone");
    String address = request.getParameter("address");
    String email = request.getParameter("email");

    boolean hasError = false;
    String errorMessage = "";
%>
<%
    // 连接服务器并校验是否已存在该用户名和电话号码
    Connection con = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    try {
        con = db.DBCPUtils.getConnection();

        String sql1 = "select count(uid) from user where uid=?";
        preparedStatement = con.prepareStatement(sql1);
        preparedStatement.setString(1, username);
        resultSet = preparedStatement.executeQuery();
        if (resultSet.next() && resultSet.getInt(1) > 0) {
            hasError = true;
            errorMessage = "用户名已存在";
            out.println("<script>showAlert('" + errorMessage + "', 'register.jsp');</script>");
        }
        resultSet.close();
        preparedStatement.close();

        if (!hasError) {
            String sql3 = "select count(telephone) from user where telephone=?";
            preparedStatement = con.prepareStatement(sql3);
            preparedStatement.setString(1, telephone);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next() && resultSet.getInt(1) > 0) {
                hasError = true;
                errorMessage = "电话号码已存在";
                out.println("<script>showAlert('" + errorMessage + "', 'register.jsp');</script>");
            }
            resultSet.close();
            preparedStatement.close();
        }

        if (!hasError) {
            // 向数据库写入用户信息
            String sql2 = "insert into user (uid, password, sex, telephone, address, email) values(?,?,?,?,?,?)";
            preparedStatement = con.prepareStatement(sql2);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, secure.MD5.encodeByMD5(password));
            preparedStatement.setString(3, sex);
            preparedStatement.setString(4, telephone);
            preparedStatement.setString(5, address);
            preparedStatement.setString(6, email);
            int res = preparedStatement.executeUpdate();

            // 显示注册结果
            if (res > 0) {
                out.println("<div class='alert alert-success' role='alert'>注册成功</div>");
            } else {
                out.println("<div class='alert alert-warning' role='alert'>注册失败，请联系管理员</div>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div class='alert alert-danger' role='alert'>系统错误，请联系管理员</div>");
    } finally {
        db.DBCPUtils.closeAll(resultSet, preparedStatement, con);
    }
%>

<!-- Static navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"></button>
            <a class="navbar-brand" href="index.jsp">购物平台</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">首页</a></li>
                <li><a href="order.jsp">我的订单</a></li>
                <li><a href="userInfo.jsp">个人中心</a></li>
                <li><a href="friendLink.jsp">四宝介绍</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-sm">
                <%
                    if (session.getAttribute("username") == null) {
                        out.println("<li><a href='login.jsp'>登录</a></li>");
                        out.println("<li><a href='register.jsp'>注册</a></li>");
                    } else {
                        out.println("<li><a href='userInfo.jsp'>" + session.getAttribute("username").toString() + " 欢迎您</a></li>");
                        out.println("<li><a href='logout.jsp'>退出</a></li>");
                    }
                %>
                <li><a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!--content-->
<div class="container">
    <div class="row thumbnail">
        <ul class='list-group'>
            <li class='list-group-item'>用户名：<%= username %></li>
            <li class='list-group-item'>密码：<%= password %></li>
            <li class='list-group-item'>性别：<%= sex %></li>
            <li class='list-group-item'>电话：<%= telephone %></li>
            <li class='list-group-item'>地址：<%= address %></li>
            <li class='list-group-item'>邮箱：<%= email %></li>
        </ul>
    </div>
</div>
<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    文房四宝购物平台
</div>

</body>
</html>
