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
    <script src="js/validator.js"></script>
    <title>订单详情</title>
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
        .list-group-item:hover {
            background: #27ae60;
        }
        .list-group-item div:first-child:hover {
            cursor: pointer;
        }
        th {
            text-align: right;
            width: 200px;
        }
        td {
            text-align: left;
            padding: 10px;
        }
        .table th {
            text-align: center;
        }
        .table td {
            text-align: center;
        }
    </style>
    <script>
        function myClick(n) {
            location.href = "OrderInfo.html";
        }
        function btnClick() {
            alert("btn");
            return false;
        }
        function validateForm() {
            var rname = document.getElementById("rname").value;
            var rtelephone = document.getElementById("rtelephone").value;
            var raddress = document.getElementById("raddress").value;

            if (!rname || !rtelephone || !raddress) {
                alert("收货人、电话和地址均为必填项。");
                return false;
            }
            return true;
        }
        function submitIt() {
            if (validateForm()) {
                document.getElementById("receiverForm").submit();
            }
        }
        $(document).ready(function() {
            $('#rname, #rtelephone, #raddress').on('input', function() {
                var rname = $('#rname').val();
                var rtelephone = $('#rtelephone').val();
                var raddress = $('#raddress').val();
                if (!rname || !rtelephone || !raddress) {
                    $('#submitOrder').prop('disabled', true);
                } else {
                    $('#submitOrder').prop('disabled', false);
                }
            });
        });
    </script>
</head>
<body>
<%
    // 初始化
    request.setCharacterEncoding("utf-8");
    // 设置变量
    String username = "N/A";
    String action = "-1";
    int globalNum = 0;
    double globalPrice = 0;
    DecimalFormat df = new DecimalFormat("######0.00");
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "";

    // 检查是否已登录
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp?err=2");
    } else {
        username = session.getAttribute("username").toString();
    }

    // 检查是否传值，若无购物车(-1)或商品页(goodsid)传值，则跳转回首页
    if (request.getParameter("action") == null) {
        response.sendRedirect("index.jsp");
    } else {
        action = request.getParameter("action");
    }

    // 获取商品数量
    int itemCount = 1; // 默认数量为1
    if (request.getParameter("number") != null) {
        try {
            itemCount = Integer.parseInt(request.getParameter("number"));
        } catch (NumberFormatException e) {
            itemCount = 1;
        }
    }

    // 连接数据库
    con = db.DBCPUtils.getConnection();
%>
<!-- 静态导航栏 -->
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
        </div>
    </div>
</div>
<!-- 内容 -->
<div class="container">
    <div class="row thumbnail center col-sm-12">
        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">订单详情</h1>
        </div>

        <div class="col-sm-12 ">
            <%
                // 获取用户信息作为默认收货人信息
                sql = "select * from user where uid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();
                rs.next();
            %>

            <form class="form-horizontal caption" id="receiverForm" data-toggle="validator" action="order.jsp" method="post">
                <div class="form-group">
                    <label for="rname" class="col-sm-3 control-label">收货人</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="rname" name="rname"
                               placeholder="收货人" value="<%=rs.getString("uid")%>"
                               data-error="收货人为必填项" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="rtelephone" class="col-sm-3 control-label">电话</label>
                    <div class="col-sm-6">
                        <input type="tel" class="form-control" id="rtelephone" name="rtelephone"
                               placeholder="电话号码" value="<%=rs.getString("telephone")%>"
                               pattern="^[1][0-9]{10}$" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="raddress" class="col-sm-3 control-label">地址</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="raddress" name="raddress"
                               value="<%=rs.getString("address")%>"
                               placeholder="地址" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div style="visibility: hidden">
                    <input type="text" name="action" value="<%=action%>">
                    <input type="text" name="number" value="<%=itemCount%>">
                </div>
            </form>
        </div>
        <div class="col-sm-12">
            <table class="table table-striped table-condensed">
                <tr>
                    <th>书名</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
                <%
                    if (Integer.parseInt(action) == -1) {
                        // 购买购物车的所有物品
                        sql = "select goodsname,price,number from goods,cart where goods.goodsid = cart.goodsid and uid = ?";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, username);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {
                            double singlePrice = Double.parseDouble(rs.getString("price"));
                            int singleNum = Integer.parseInt(rs.getString("number"));
                            String total = df.format(singlePrice * singleNum);
                            globalNum += singleNum;
                            globalPrice += singlePrice * singleNum;
                %>
                <tr>
                    <td><%=rs.getString("goodsname")%></td>
                    <td><%=rs.getString("price")%></td>
                    <td><%=rs.getString("number")%></td>
                    <td><%=total%></td>
                </tr>
                <%
                    }
                } else {
                    sql = "select goodsname, price from goods where goodsid = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, action);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        globalNum += itemCount;
                        double unitPrice = Double.parseDouble(rs.getString("price"));
                        globalPrice = unitPrice * itemCount;
                %>
                <tr>
                    <td><%=rs.getString("goodsname")%></td>
                    <td><%=df.format(unitPrice)%></td>
                    <td><%=itemCount%></td>
                    <td><%=df.format(globalPrice)%></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>

        <div class="col-sm-12 ">
            <table>
                <tr>
                    <th></th>
                    <th></th>
                    <th>商品总数：</th>
                    <td><%=globalNum%></td>
                    <th>订单总价：</th>
                    <td><span class="text-danger"><%=df.format(globalPrice)%></span></td>
                </tr>
            </table>
        </div>
    </div>
    <div class="col-sm-offset-7 col-sm-5" style="padding: 30px;">
        <div class="col-sm-6 btn btn-success btn-block" onclick="javascript:location.href='index.jsp'">继续购物</div>
        <div class="col-sm-6 btn btn-success btn-block" id="submitOrder" onclick="submitIt()">提交订单</div>
    </div>
</div>
<%
    db.DBCPUtils.closeAll(rs, pstmt, con);
%>
<!-- 页脚 -->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    文房四宝购物平台
</div>
</body>
</html>
