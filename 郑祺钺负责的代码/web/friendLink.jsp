<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta charset="UTF-8">

    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/flat-ui.min.css"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/flat-ui.min.js"></script>
    <title></title>
    <style type="text/css">
        body{
            background-image:url("image/background.png");    //设置背景样式
        background-size:cover;
        }
        h3{
            font-size: 30px;
            height: 45px; /* 设置固定高度限制为2行，超高隐藏，防止因标题过长而导致各模块大小不一致*/
            text-align: center;
        }
    </style>

</head>
<body>
<!-- Static navbar -->
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
                <li class="active"><a href="friendLink.jsp">四宝介绍</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-sm">
                <%
                    if(session.getAttribute("username")==null){
                        out.println("<li><a href='login.jsp'>登录</a></li>");
                        out.println("<li><a href='register.jsp'>注册</a></li>");
                    }else{
                        out.println("<li><a href='userInfo.jsp'>"+session.getAttribute("username").toString()+" 欢迎您</a></li>");
                        out.println("<li><a href='logout.jsp'>退出</a></li>");
                    }
                %>
                <li>
                    <a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!--content-->

<!--content-->
<div class="container">
    <div class="jumbotron">
        <h3>文房四宝，即笔、墨、纸、砚，是中国独有的书法绘画工具，具有深厚的文化底蕴和艺术价值。它们不仅是文人书房中必备的四件宝贝，也是中国传统文化的精髓和象征。</h3><br><br>
        <p>1. 笔</p>
        <p>•种类：按毛质可分为硬毫（如狼毫、紫毫）、软毫（如山羊毛）、兼毫（如紫毫夹羊毫）等；按形状可分为圆笔、扁笔等；按用途可分为书法笔、绘画笔等。</p>
        <p>•特点：毛笔的发明据传是秦代名将蒙恬所创，其历史悠久，工艺精湛。著名产地有浙江湖州的湖笔，以毛质细软、笔锋灵活、吸水力强而闻名。</p>
        <p>2. 墨</p>
        <p>•种类：按原料可分为松烟墨、油烟墨等；按品质可分为徽墨、李墨等；按形状可分为方墨、圆墨等；按用途可分为书法墨、绘画墨等。</p>
        <p>•特点：墨的制作需要经过多道工序，如选料、烧炉、熏烟、收烟、研磨等，其品质直接影响书画作品的效果。著名产地有安徽徽州歙县的徽墨，以墨色深沉、墨香幽雅、墨质细腻而著称。</p>
        <p>3. 纸</p>
        <p>•种类：有宣纸、毛太纸、竹纸、麻纸等不同类型，适合不同的书法和绘画风格。</p>
        <p>•特点：纸作为书写绘画的载体，其品质对书画作品的影响至关重要。著名产地有安徽宣城泾县的宣纸，是中国传统文化中重要的书画用纸，具有质地细腻、吸墨性强等特点。</p>
        <p>4. 砚</p>
        <p>•种类：有歙砚（安徽徽州歙县）、洮砚（甘肃卓尼县）、端砚（广东肇庆，古称端州）等著名品种。</p>
        <p>•特点：砚台用于研磨墨块，其质地、吸墨性能和保水性能对书写绘画效果有重要影响。砚台的制作同样需要精湛的工艺和技巧。</p>
    </div>
</div>

<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    文房四宝
</div>
</body>
</html>