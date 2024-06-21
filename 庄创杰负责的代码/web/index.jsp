<%@ page import="java.sql.Connection" %><%--导入与数据库连接--%>
<%@ page import="java.sql.PreparedStatement" %><%--Connection接口的一个子接口，用于执行参数化的SQL语句--%>
<%@ page import="java.sql.ResultSet" %><%--处理执行SQL查询后返回的数据。--%>
<%@ page import="java.sql.Statement" %><%--执行SQL语句和返回ResultSet的基本接口--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ page import="DBTest" %>--%>
<html>
<head lang="en">
    <meta charset="UTF-8">
<%--通过<link>标签引入了Bootstrap和Flat-UI的CSS样式文件，<script>标签引入了jQuery、Bootstrap和Flat-UI的JavaScript文件。--%>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/flat-ui.min.css"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/flat-ui.min.js"></script>
    <title>文房四宝购物平台</title>
<%--定义了一些CSS样式，如背景图像、边距和图片样式。--%>
    <style type="text/css">
        body{
            background-image:url("image/background.png");
        background-size:cover;
        }
        .row{
            margin-top: 20px;;
        }
        .center{
            text-align: center;
        }
        img{
            width: 100%;
            height: 150px;
            display: block;/*图像将有自己的块级空间*/
            object-fit: contain;/*图像的宽高比例保持不变，且适应容器*/
        }
        h3{
            font-size: 20px;
            height: 50px; /* 设置固定高度限制为2行，超高隐藏，防止因标题过长而导致各模块大小不一致*/
            overflow: hidden;
        }
    </style>
</head>
<body>
<%
    // 定义每个商品的goodsid(GET方法跳转查书),goodsname,price,picpath
    String[][] goodsid = new String[4][8];
    String[][] goodsname = new String[4][8];
    String[][] price = new String[4][8];
    String[][] picpath = new String[4][8];

    // 连接数据库，获取对应类别下商品数据
    Connection con = db.DBCPUtils.getConnection();
    String sql = "select goodsid, goodsname, price, picpath from goods limit 10 offset 0 ";
    Statement stmt = con.createStatement();/*创建Statement对象*/
    ResultSet rs = stmt.executeQuery(sql);/*执行查询并获取结果*/
    int k = 0;
/*rs.next()是ResultSet接口中定义的一个方法，用于移动光标到结果集的下一行。
如果当前行有效（即存在下一行），则该方法返回 true；如果已经到达结果集的末尾（即不存在下一行），则返回 false。*/
    for(int i=0;i<8;i++){
        if(rs.next()){
            goodsid[k][i] = rs.getString("goodsid");
            goodsname[k][i] = rs.getString("goodsname");
            price[k][i] = rs.getString("price");
            picpath[k][i] = rs.getString("picpath");
        }else{
            goodsid[k][i] = "0000";
            goodsname[k][i] = "N/A";
            price[k][i] = "0.00";
            picpath[k][i] = "img/goods/0000.jpg";/*敬请期待*/
        }
    }
    sql = "select goodsid, goodsname, price, picpath from goods limit 10 offset 10 ";
    stmt = con.createStatement();
    rs = stmt.executeQuery(sql);
    k = 1;
    for(int i=0;i<8;i++){
        if(rs.next()){
            goodsid[k][i] = rs.getString("goodsid");
            goodsname[k][i] = rs.getString("goodsname");
            price[k][i] = rs.getString("price");
            picpath[k][i] = rs.getString("picpath");
        }else{
            goodsid[k][i] = "0000";
            goodsname[k][i] = "N/A";
            price[k][i] = "0.00";
            picpath[k][i] = "img/goods/0000.jpg";
        }
    }
    sql = "select goodsid, goodsname, price, picpath from goods limit 10 offset 20 ";
    stmt = con.createStatement();
    rs = stmt.executeQuery(sql);
    k = 2;
    for(int i=0;i<8;i++){
        if(rs.next()){
            goodsid[k][i] = rs.getString("goodsid");
            goodsname[k][i] = rs.getString("goodsname");
            price[k][i] = rs.getString("price");
            picpath[k][i] = rs.getString("picpath");
        }else{
            goodsid[k][i] = "0000";
            goodsname[k][i] = "N/A";
            price[k][i] = "0.00";
            picpath[k][i] = "img/goods/0000.jpg";
        }
    }
    sql = "select goodsid, goodsname, price, picpath from goods limit 10 offset 30 ";
    stmt = con.createStatement();
    rs = stmt.executeQuery(sql);
    k = 3;
    for(int i=0;i<8;i++){
        if(rs.next()){
            goodsid[k][i] = rs.getString("goodsid");
            goodsname[k][i] = rs.getString("goodsname");
            price[k][i] = rs.getString("price");
            picpath[k][i] = rs.getString("picpath");
        }else{
            goodsid[k][i] = "0000";
            goodsname[k][i] = "N/A";
            price[k][i] = "0.00";
            picpath[k][i] = "img/goods/0000.jpg";
        }
    }
    db.DBCPUtils.closeAll(rs,stmt,con);//关闭数据库资源。
%>



<!-- Static navbar -->
<%--定义了导航栏的容器，并且应用了Bootstrap的预定义类：
navbar：基本的导航栏类。
navbar-default：为导航栏提供默认的Bootstrap风格。
navbar-static-top：使导航栏固定在页面顶部，不随页面滚动而移动。
--%>
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"></button><%--按钮，用于在小屏幕上切换导航栏的显示和隐藏。--%>
            <a class="navbar-brand" href="index.jsp">购物平台</a><%--品牌链接--%>
        </div>
        <div class="navbar-collapse collapse"><%--可折叠部分--%>
            <ul class="nav navbar-nav"><%--水平排列--%>
                <li class="active"><a href="index.jsp">首页</a></li>
                <li><a href="order.jsp">我的订单</a></li>
                <li><a href="userInfo.jsp">个人中心</a></li>
                <li><a href="friendLink.jsp">四宝介绍</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-sm"><%--小屏幕尺寸下，这些导航链接将不可见--%>
                <%
/*如果用户未登录，则显示登录和注册链接；如果用户已登录，则显示欢迎信息和退出链接。*/
                    if(session.getAttribute("username")==null){
                        out.println("<li><a href='login.jsp'>登录</a></li>");
                        out.println("<li><a href='register.jsp'>注册</a></li>");
                    }else{
                        out.println("<li><a href='userInfo.jsp'>"+session.getAttribute("username").toString()+" 欢迎您</a></li>");
                        out.println("<li><a href='logout.jsp'>退出</a></li>");
                    }
                %>

                <li><a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li><%--添加了一个Bootstrap的Glyphicon图标--%>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!--content-->
<div class="container">
    <div class="jumbotron"><%--巨幕图--%>
        <h1>文房四宝购物平台</h1>
        <p>欢迎光临！</p>
    </div>

    <ul class="nav nav-tabs" id="myTabs"><%--使用Bootstrap的nav-tabs组件创建的导航标签列表--%>
        <%--active类表示第一个标签页默认为活动状态，data-toggle激活Bootstrap的标签页功能--%>
        <li class="active"><a href="#tab1" data-toggle="tab" >笔</a></li>
        <li><a href="#tab2" data-toggle="tab">墨</a></li>
        <li><a href="#tab3" data-toggle="tab">纸</a></li>
        <li><a href="#tab4" data-toggle="tab">砚</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="tab1">
            <%
                k = 0;
            %>
            <div class="row">
                <%--商品No1--%>
                <div class="col-sm-4 col-md-3"><%--定义了元素在小屏幕和中屏幕尺寸下的宽度--%>
                    <div class="thumbnail" ><%--缩略图容器--%>
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][0]%>" data-src="holder.js/100%x200" data-holder-rendered="false"><%--alt:替代文本,data-src:图片加载前显示一个占位符--%>
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][0]%></h3>
                            <p><span>价格:</span><span><%=price[k][0]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][0]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No2--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][1]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][1]%></h3>
                            <p><span>价格:</span><span><%=price[k][1]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href=goodsInfo.jsp?goodsid=<%=goodsid[k][1]%>>查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No3--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][2]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][2]%></h3>
                            <p><span>价格:</span><span><%=price[k][2]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][2]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No4--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][3]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][3]%></h3>
                            <p><span>价格:</span><span><%=price[k][3]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][3]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No5--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][4]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][4]%></h3>
                            <p><span>价格:</span><span><%=price[k][4]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][4]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No6--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][5]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][5]%></h3>
                            <p><span>价格:</span><span><%=price[k][5]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][5]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No7--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][6]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][6]%></h3>
                            <p><span>价格:</span><span><%=price[k][6]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][6]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No8--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][7]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][7]%></h3>
                            <p><span>价格:</span><span><%=price[k][7]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][7]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="tab2">
            <%
                k = 1;
            %>
            <div class="row">
                <%--商品No1--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][0]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][0]%></h3>
                            <p><span>价格:</span><span><%=price[k][0]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][0]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No2--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][1]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][1]%></h3>
                            <p><span>价格:</span><span><%=price[k][1]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href=goodsInfo.jsp?goodsid=<%=goodsid[k][1]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No3--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][2]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][2]%></h3>
                            <p><span>价格:</span><span><%=price[k][2]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][2]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No4--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][3]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][3]%></h3>
                            <p><span>价格:</span><span><%=price[k][3]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][3]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No5--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][4]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][4]%></h3>
                            <p><span>价格:</span><span><%=price[k][4]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][4]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No6--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][5]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][5]%></h3>
                            <p><span>价格:</span><span><%=price[k][5]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][5]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No7--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][6]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][6]%></h3>
                            <p><span>价格:</span><span><%=price[k][6]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][6]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No8--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][7]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][7]%></h3>
                            <p><span>价格:</span><span><%=price[k][7]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][7]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="tab3">
            <%
                k = 2;
            %>
            <div class="row">
                <%--商品No1--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][0]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][0]%></h3>
                            <p><span>价格:</span><span><%=price[k][0]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][0]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No2--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][1]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][1]%></h3>
                            <p><span>价格:</span><span><%=price[k][1]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href=goodsInfo.jsp?goodsid=<%=goodsid[k][1]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No3--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][2]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][2]%></h3>
                            <p><span>价格:</span><span><%=price[k][2]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][2]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No4--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][3]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][3]%></h3>
                            <p><span>价格:</span><span><%=price[k][3]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][3]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No5--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][4]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][4]%></h3>
                            <p><span>价格:</span><span><%=price[k][4]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][4]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No6--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][5]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][5]%></h3>
                            <p><span>价格:</span><span><%=price[k][5]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][5]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No7--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][6]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][6]%></h3>
                            <p><span>价格:</span><span><%=price[k][6]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][6]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No8--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][7]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][7]%></h3>
                            <p><span>价格:</span><span><%=price[k][7]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][7]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="tab4">
            <%
                k = 3;
            %>
            <div class="row">
                <%--商品No1--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][0]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][0]%></h3>
                            <p><span>价格:</span><span><%=price[k][0]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][0]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No2--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][1]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][1]%></h3>
                            <p><span>价格:</span><span><%=price[k][1]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href=goodsInfo.jsp?goodsid=<%=goodsid[k][1]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No3--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][2]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][2]%></h3>
                            <p><span>价格:</span><span><%=price[k][2]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][2]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No4--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][3]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][3]%></h3>
                            <p><span>价格:</span><span><%=price[k][3]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][3]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No5--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][4]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][4]%></h3>
                            <p><span>价格:</span><span><%=price[k][4]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][4]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No6--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][5]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][5]%></h3>
                            <p><span>价格:</span><span><%=price[k][5]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][5]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No7--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][6]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][6]%></h3>
                            <p><span>价格:</span><span><%=price[k][6]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][6]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
                <%--商品No8--%>
                <div class="col-sm-4 col-md-3">
                    <div class="thumbnail" >
                        <a href="goodsInfo.jsp">
                            <img alt="100%x200" src="<%=picpath[k][7]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                        </a>
                        <div class="caption center">
                            <h3><%=goodsname[k][7]%></h3>
                            <p><span>价格:</span><span><%=price[k][7]%></span></p>
                            <p><a class="btn btn-primary btn-block" role="button" href="goodsInfo.jsp?goodsid=<%=goodsid[k][7]%>">查看详情</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row"></div>

</div>
<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    文房四宝购物平台
</div>
</body>
</html>