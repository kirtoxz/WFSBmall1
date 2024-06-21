<!-- 购物车页面 -->
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/flat-ui.min.css"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/flat-ui.min.js"></script>
    <title>购物车</title>
    <style type="text/css">
        body {
            background-image: url("image/background.png");
            background-size: cover; /* 自适应界面大小 */
        }
        .row {
            margin-left: 20px;
            margin-right: 20px;
        }
        .line-center {
            line-height: 50px;
            text-align: center;
        }
        .row input {
            width: 50px;
        }
    </style>
</head>
<body>
<%
    // 页面初始化
    request.setCharacterEncoding("utf-8");
    // 定义变量
    String username = "N/A";
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql;
    int globalTotalgoods = 0;
    double globalTotalPrice = 0;
    DecimalFormat df = new DecimalFormat("######0.00");
    // 获取用户信息，若无用户信息则跳转登录界面
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp?err=2");
    } else {
        username = session.getAttribute("username").toString();
    }
%>

<!-- 静态导航栏 -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            </button>
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
                <li class="active">
                    <a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div>
    </div>
</div>
<!-- 内容 -->
<div class="container">
    <div class="row thumbnail center">
        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">购物车</h1>
        </div>
        <div class="list-group">
            <div class="col-sm-12 thumbnail">
                <div class="col-sm-4 line-center">商品</div>
                <div class="col-sm-1 line-center">单价</div>
                <div class="col-sm-4 line-center">数量</div>
                <div class="col-sm-2 line-center">小计</div>
                <div class="col-sm-1 line-center">操作</div>
            </div>
            <%
                // 连接数据库，获取订单信息
                try {
                    con = db.DBCPUtils.getConnection();
                    sql = "select goods.goodsid,goodsname,price,number from goods,cart where goods.goodsid = cart.goodsid AND uid= ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, username);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        int iNum = Integer.parseInt(rs.getString("number"));
                        double dPrice = Double.parseDouble(rs.getString("price"));
                        globalTotalgoods += iNum;
                        globalTotalPrice += dPrice * iNum;
                        String totalprice = df.format(dPrice * iNum);
            %>
            <div class="col-sm-12 list-group-item">
                <div class="col-sm-1 line-center" style="width: 50px;height: 50px;">
                    <img src="img/icons/png/goods.png" style="height: 100%;" alt=""/>
                </div>
                <div class="col-sm-3 line-center"><%= rs.getString("goodsname") %></div>
                <div class="col-sm-1 line-center"><%= rs.getString("price") %></div>
                <div class="col-sm-4 line-center">
                    <button type="button" class="btn btn-default" name="up" onclick="javascript:location.href='cart.jsp?action=down&goodsid=<%= rs.getString(1) %>&number=<%= rs.getString("number") %>'">
                        <span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
                    </button>
                    <input type="text" class="small" readonly value="<%= rs.getString("number") %>"/>
                    <button type="button" class="btn btn-default" name="down" onclick="javascript:location.href='cart.jsp?action=up&goodsid=<%= rs.getString(1) %>&number=<%= rs.getString("number") %>'">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                    </button>
                </div>
                <div class="col-sm-2 line-center"><%= totalprice %></div>
                <div class="col-sm-1 line-center">
                    <button class="btn btn-danger" onclick="javascript:location.href='cart.jsp?action=down&goodsid=<%= rs.getString(1) %>&number=-1'">删除</button>
                </div>
            </div>
            <%
                    }

                } catch (Exception e) {
                    out.println("<script>alert('数据库错误，请联系管理员');</script>");
                }
            %>
            <%
                if (request.getParameter("action") != null) {
                    String _goodsid = request.getParameter("goodsid");
                    String sNumber = request.getParameter("number");

                    if (_goodsid != null && sNumber != null) {
                        int _number = Integer.parseInt(sNumber);
                        if ("up".equals(request.getParameter("action"))) {
                            // 增加
                            _number++;
                        } else if ("down".equals(request.getParameter("action"))) {
                            // 减少
                            _number--;
                        }
                        sNumber = Integer.toString(_number);
                        if (_number > 0) {
                            sql = "update cart set number = ? where uid = ? and goodsid = ?";
                            pstmt = con.prepareStatement(sql);
                            pstmt.setString(1, sNumber);
                            pstmt.setString(2, username);
                            pstmt.setString(3, _goodsid);
                            pstmt.executeUpdate();
                        } else {
                            sql = "delete from cart where uid = ? and goodsid = ?";
                            pstmt = con.prepareStatement(sql);
                            pstmt.setString(1, username);
                            pstmt.setString(2, _goodsid);
                            pstmt.executeUpdate();
                        }

                        response.sendRedirect("cart.jsp");
                    }
                }
            %>

            <div class="col-sm-12 thumbnail">
                <div class="col-sm-offset-4 col-sm-2 text-right">总数：</div>
                <div class="col-sm-2"><%= globalTotalgoods %></div>
                <div class="col-sm-2 text-right">总价：</div>
                <div class="col-sm-2"><%= df.format(globalTotalPrice) %></div>
            </div>
        </div>
        <div class="col-sm-offset-7 col-sm-5" style="padding: 30px;">
            <div class="col-sm-6 btn btn-success btn-block" onclick="javascript:location.href='index.jsp'">继续购物</div>
            <%
                sql = "select * from cart where uid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();
                if (rs.next()) {
            %>
            <div class="col-sm-6 btn btn-success btn-block" onclick="javascript:location.href='orderInfo.jsp?action=-1'">提交订单</div>
            <%
            } else {
            %>
            <div class="col-sm-6 btn disabled btn-block">提交订单</div>
            <%
                }
            %>
        </div>
    </div>
</div>
<%
    if (request.getParameter("addcart") != null) {
        String addCartGoodsId = request.getParameter("addcart");
        String addCartNumber = request.getParameter("number");

        sql = "select number from cart where uid = ? and goodsid = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, addCartGoodsId);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            int currentNumber = Integer.parseInt(rs.getString("number"));
            int newNumber = currentNumber + Integer.parseInt(addCartNumber);
            sql = "update cart set number = ? where uid = ? and goodsid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, Integer.toString(newNumber));
            pstmt.setString(2, username);
            pstmt.setString(3, addCartGoodsId);
            pstmt.executeUpdate();
        } else {
            sql = "insert into cart(uid, goodsid, number) values (?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, addCartGoodsId);
            pstmt.setString(3, addCartNumber);
            pstmt.executeUpdate();
        }
        response.sendRedirect("cart.jsp");
    }
%>
<!-- 页脚 -->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    文房四宝购物平台
</div>
<%
    db.DBCPUtils.closeAll(rs, pstmt, con);
%>
</body>
</html>
