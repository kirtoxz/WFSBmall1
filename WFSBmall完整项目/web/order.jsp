<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>
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
    <title>订单处理</title>
    <style type="text/css">
        body {
            background-image: url("image/background.png");
            background-size: cover;
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
        .list-group-item {
            height: 100px; /* 设置固定高度 */
            overflow: hidden; /* 超出内容隐藏 */
            display: flex;
            align-items: center; /* 垂直居中 */
        }
        .list-group-item:hover {
            background: #27ae60;
        }
        .list-group-item div:first-child:hover {
            cursor: pointer;
        }
    </style>
    <script>
        function confirmDelete(orderId) {
            if (confirm("您确定要删除该订单吗？")) {
                // 确认删除，进行删除操作
                window.location.href = 'order.jsp?func=deleteit&orderid=' + orderId;
            }
        }
        function btnClick() {
            alert("btn");
            return false;
        }
        $(function() {
            // 页面初始化
        });
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");

    String username = "N/A";
    String action = "";
    DecimalFormat dec = new DecimalFormat("######0.00");
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "";

    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp?err=2");
    } else {
        username = session.getAttribute("username").toString();
    }

    con = db.DBCPUtils.getConnection();
%>

<%
    if (request.getParameter("action") != null) {
        action = request.getParameter("action");
        String orderId = System.currentTimeMillis() + username;

        String rname = request.getParameter("rname");
        String raddress = request.getParameter("raddress");
        String rtelephone = request.getParameter("rtelephone");
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");

        sql = "insert into orderlist values(?,?,?,?,?,?,?,?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, orderId);
        pstmt.setString(2, username);
        pstmt.setString(3, df.format(new Date()));
        pstmt.setString(4, "to be finished");
        pstmt.setString(5, rname);
        pstmt.setString(6, raddress);
        pstmt.setString(7, rtelephone);
        pstmt.setString(8, "to be payed");

        int itemCount = 1;
        if (request.getParameter("number") != null) {
            try {
                itemCount = Integer.parseInt(request.getParameter("number"));
            } catch (NumberFormatException e) {
                itemCount = 1;
            }
        }

        if ("-1".equals(action)) {
            out.println("<script>console.log('执行整体订单操作');</script>");
            if (pstmt.executeUpdate() == 1) {
                ArrayList<String> algoodsid = new ArrayList<>();
                ArrayList<String> alPrice = new ArrayList<>();
                ArrayList<String> alNumber = new ArrayList<>();

                sql = "select cart.goodsid, price, number from cart, goods where cart.goodsid = goods.goodsid and uid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    algoodsid.add(rs.getString(1));
                    alPrice.add(rs.getString(2));
                    alNumber.add(rs.getString(3));
                }

                String[] argoodsid = algoodsid.toArray(new String[0]);
                String[] arPrice = alPrice.toArray(new String[0]);
                String[] arNumber = alNumber.toArray(new String[0]);
                sql = "insert into orderdetail values(?,?,?,?)";
                for (int i = 0; i < argoodsid.length; i++) {
                    pstmt = con.prepareStatement(sql);
                    double pri = Double.parseDouble(arPrice[i]);
                    int n = Integer.parseInt(arNumber[i]);
                    String totalPrice = dec.format(pri * n);
                    pstmt.setString(1, orderId);
                    pstmt.setString(2, argoodsid[i]);
                    pstmt.setString(3, arNumber[i]);
                    pstmt.setString(4, totalPrice);
                    pstmt.executeUpdate();
                }
                sql = "delete from cart where uid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.executeUpdate();
                out.println("<script>alert('订单提交成功！');</script>");
            }
        } else if (rname != null && raddress != null && rtelephone != null) {
            out.println("<script>console.log('执行单个订单操作');</script>");
            if (pstmt.executeUpdate() == 1) {
                sql = "select price from goods where goodsid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, action);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    String price = rs.getString("price");
                    sql = "insert into orderdetail values(?, ?, ?, ?)";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, orderId);
                    pstmt.setString(2, action);
                    pstmt.setString(3, String.valueOf(itemCount));
                    String totalPrice = dec.format(Double.parseDouble(price) * itemCount);
                    pstmt.setString(4, totalPrice);
                    if (pstmt.executeUpdate() == 1) {
                        out.println("<script>alert('订单提交成功！');</script>");
                    } else {
                        out.println("<script>alert('订单提交失败！');</script>");
                    }
                }
            }
        }
    }
%>

<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"></button>
            <a class="navbar-brand" href="index.jsp">购物平台</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">首页</a></li>
                <li class="active"><a href="order.jsp">我的订单</a></li>
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
        </div>
    </div>
</div>

<div class="container">
    <div class="row thumbnail center">
        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">我的订单</h1>
        </div>
        <div class="col-sm-12 thumbnail">
            <div class="col-sm-3 line-center">订单编号</div>
            <div class="col-sm-1 line-center">数量</div>
            <div class="col-sm-2 line-center">订单总价</div>
            <div class="col-sm-2 line-center">支付状态</div>
            <div class="col-sm-2 line-center">订单状态</div>
            <div class="col-sm-2 line-center">操作</div>
        </div>
        <div class="list-group">
            <%
                sql = "select orderlist.orderid, count(goodsid), sum(tprice), paystatus , status from orderlist, orderdetail where orderlist.orderid = orderdetail.orderid and uid = ? group by orderdetail.orderid";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();
                while (rs.next()) {
            %>
            <div class="col-sm-12 list-group-item">
                <div class="col-sm-3 line-center"><%= rs.getString(1) %></div>
                <div class="col-sm-1 line-center"><%= rs.getString(2) %></div>
                <div class="col-sm-2 line-center"><%= rs.getString(3) %> 元</div>
                <div class="col-sm-2 line-center"><%= rs.getString(4) %></div>
                <div class="col-sm-2 line-center"><%= rs.getString(5) %></div>
                <div class="col-sm-2 line-center">
                    <button class="btn btn-danger" onclick="confirmDelete('<%= rs.getString(1) %>')">删除订单</button>
                    <%
                        String payStatus = rs.getString(4);
                        if ("to be payed".equals(payStatus)) {
                    %>
                    <button class="btn btn-success" onclick="javascript:location.href='order.jsp?func=payit&orderid=<%= rs.getString(1) %>'">完成支付</button>
                    <% } else if ("payed".equals(payStatus) && !"finish".equals(rs.getString(5))) { %>
                    <button class="btn btn-success" onclick="javascript:location.href='order.jsp?func=finishit&orderid=<%= rs.getString(1) %>'">完成订单</button>
                    <% } %>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    文房四宝购物平台
</div>
<%
    if (request.getParameter("func") != null && request.getParameter("orderid") != null) {
        String func = request.getParameter("func");
        String orderid = request.getParameter("orderid");
        if ("deleteit".equals(func)) {
            sql = "delete from orderlist where orderid = ?";
        } else if ("payit".equals(func)) {
            sql = "update orderlist set paystatus = 'payed' where orderid = ?";
        } else if ("finishit".equals(func)) {
            sql = "update orderlist set status = 'finish' where orderid = ?";
        }
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, orderid);
        pstmt.executeUpdate();
        response.sendRedirect("order.jsp");
    }
%>

<%
    db.DBCPUtils.closeAll(rs, pstmt, con);
%>
</body>
</html>
