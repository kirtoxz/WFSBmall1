<!-- 商品详情页 -->
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
    <title>商品详情</title>
    <style type="text/css">
        body {
            background-image: url("image/background.png");
            background-size: cover; /*自适应界面大小*/
        }
        .row {
            margin-left: 20px;
            margin-right: 20px;
        }
        .center {
            text-align: center;
        }
        .caption p {
            font-size: 1.5em;
        }
        img {
            width: 100%;
            display: block;
        }
        #counter-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px; /* 调整按钮和计数器之间的间距 */
        }
        #counter-container button {
            padding: 5px 10px;
            font-size: 16px;
        }
        .quantity-label {
            font-size: 1.2em;
            margin-right: 10px;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const hiddenCountInput = document.getElementById('hidden-count');
            let count = parseInt(hiddenCountInput.value, 10) || 1; // 确保count有默认值1

            const counterValue = document.getElementById('counter-value');
            counterValue.textContent = count;

            function decreaseCount() {
                count = Math.max(count - 1, 1);
                updateCounterDisplay();
                updateButtonLinks();
            }

            function increaseCount() {
                count++;
                updateCounterDisplay();
                updateButtonLinks();
            }

            function updateCounterDisplay() {
                counterValue.textContent = count;
                hiddenCountInput.value = count; // 更新隐藏输入字段
            }

            function updateButtonLinks() {
                const goodsid = hiddenCountInput.dataset.goodsid;
                const buyButton = document.getElementById('buy-button');
                const cartButton = document.getElementById('cart-button');

                if (buyButton.dataset.isLoggedIn === 'true') {
                    buyButton.href = "orderInfo.jsp?action=" + goodsid + "&number=" + count;
                    cartButton.href = "cart.jsp?addcart=" + goodsid + "&number=" + count;
                } else {
                    buyButton.href = "javascript:redirectToLoginWithAlert();";
                    cartButton.href = "javascript:redirectToLoginWithAlert();";
                }
            }

            document.getElementById('decrease-btn').addEventListener('click', decreaseCount);
            document.getElementById('increase-btn').addEventListener('click', increaseCount);

            if (count === 0) {
                document.getElementById('decrease-btn').disabled = true;
            }
        });

        function redirectToLoginWithAlert() {
            alert('请在登录后重新选购商品');
            window.location.href = 'login.jsp';
        }
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String goodsid = request.getParameter("goodsid");
    if (goodsid == null) {
        goodsid = "1001"; // 若获取传值失败，则使用1001号商品
    }
    String goodsname = "N/A";
    String category = "N/A";
    String introduction = "未查询到此书相关信息，请联系管理员解决";
    String price = "N/A";
    String picpath = "img/goods/0000.jpg";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql;
    try {
        sql = "select * from goods where goodsid = ?";
        con = db.DBCPUtils.getConnection();
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, goodsid);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            goodsname = rs.getString("goodsname");
            category = rs.getString("category");
            introduction = rs.getString("introduction");
            price = rs.getString("price");
            picpath = rs.getString("picpath");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        db.DBCPUtils.closeAll(rs, pstmt, con);
    }

    boolean isLoggedIn = session.getAttribute("username") != null;
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
                <li class="active"><a href="index.jsp">首页</a></li>
                <li><a href="order.jsp">我的订单</a></li>
                <li><a href="userInfo.jsp">个人中心</a></li>
                <li><a href="friendLink.jsp">四宝介绍</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-sm">
                <%
                    if (!isLoggedIn) {
                        out.println("<li><a href='login.jsp'>登录</a></li>");
                        out.println("<li><a href='register.jsp'>注册</a></li>");
                    } else {
                        out.println("<li><a href='userInfo.jsp'>" + session.getAttribute("username").toString() + " 欢迎您</a></li>");
                        out.println("<li><a href='logout.jsp'>退出</a></li>");
                    }
                %>
                <li>
                    <a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div>
    </div>
</div>
<!-- 内容 -->
<div class="row thumbnail">
    <div class="col-sm-4">
        <img src="<%= picpath %>" data-holder-rendered="true">
        <div class="caption center">
            <h3><%= goodsname %></h3>
            <table class="table table-striped">
                <tr><th class="text-center">单价</th><th class="text-center"><%= price %></th></tr>
                <tr class="text-center"><td>分类</td><td><%= category %></td></tr>
            </table>
            <div id="counter-container">
                <label class="quantity-label">购买数量：</label>
                <button type="button" id="decrease-btn">-</button>
                <span id="counter-value">1</span>
                <button type="button" id="increase-btn">+</button>
            </div>
            <p>
                <input type="hidden" id="hidden-count" data-goodsid="<%= goodsid %>" value="1">
                <%
                    // 判断用户是否登录
                    if (!isLoggedIn) {
                %>
                <a class="btn btn-primary btn-block" id="buy-button" role="button" href="javascript:redirectToLoginWithAlert();" data-is-logged-in="false">立即购买</a>
                <a class="btn btn-primary btn-block" id="cart-button" role="button" href="javascript:redirectToLoginWithAlert();" data-is-logged-in="false">加入购物车</a>
                <%
                } else {
                %>
                <a class="btn btn-primary btn-block" id="buy-button" role="button" href="orderInfo.jsp?action=<%= goodsid %>&number=1" data-is-logged-in="true">立即购买</a>
                <a class="btn btn-primary btn-block" id="cart-button" role="button" href="cart.jsp?addcart=<%= goodsid %>&number=1" data-is-logged-in="true">加入购物车</a>
                <%
                    }
                %>
            </p>
        </div>
    </div>
    <div class="col-sm-8">
        <div class="caption">
            <h3>商品介绍</h3>
            <p><%= introduction %></p>
        </div>
    </div>
</div>
<!-- 页脚 -->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    文房四宝
</div>
</body>
</html>
