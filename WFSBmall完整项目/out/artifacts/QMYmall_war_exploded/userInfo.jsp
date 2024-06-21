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
    <script src="js/validator.js"></script>
    <title>个人中心</title>
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
            width: 10%;
            padding: 10px;
        }
        td {
            text-align: left;
            width: 30%;
            padding: 10px;
        }
        .table th {
            text-align: center;
        }
        .table td {
            text-align: center;
        }
        .error-border {
            border-color: #dc143c !important;
        }
        .error-message {
            color: #dc143c;
            font-size: 14px;
            display: none;
        }
        .has-error .help-block.with-errors {
            color: #dc143c; /* 红色 */
            font-size: 14px; /* 14像素字体大小 */
        }
        .error-label {
            color: #dc143c !important;
        }
    </style>
    <script>
        $(function() {
            $('#myTabs a').click(function(e) {
                $(this).tab('show');
            });
            $('#password1, #password0').on('input', function() {
                validatePassword();
            });

            function validatePassword() {
                var originalPassword = $('#password0').val();
                var newPassword = $('#password1').val();
                var submitButton = $('#submitButton');
                var passwordError = $('#passwordError');
                var passwordLabel = $('label[for="password1"]');

                if (newPassword === originalPassword && newPassword !== '') {
                    $('#password1').addClass('error-border');
                    passwordLabel.addClass('error-label');
                    passwordError.show();
                    submitButton.prop('disabled', true);
                } else {
                    $('#password1').removeClass('error-border');
                    passwordLabel.removeClass('error-label');
                    passwordError.hide();
                    submitButton.prop('disabled', false);
                }
            }
        });
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String username = "N/A";
    String _sex = "N/A";
    String telephone = "N/A";
    String address = "N/A";
    String email = "N/A";
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql;

    if(session.getAttribute("username") == null){
        response.sendRedirect("login.jsp?err=2");
    }else{
        username = session.getAttribute("username").toString();
    }

    try {
        sql = "select * from user where uid = ?";
        con = db.DBCPUtils.getConnection();
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        if(rs.next()){
            _sex = rs.getString("sex");
            telephone = rs.getString("telephone");
            address = rs.getString("address");
            email = rs.getString("email");
        } else {
            response.sendRedirect("login.jsp?err=2");
        }
    } catch (Exception e) {
        out.println("<script>alert('数据库连接出现问题，请联系管理员');</script>");
    }

    String sex = "男";
    if("1".equals(_sex)){
        sex = "女";
    }
%>

<!-- Static navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">切换导航</span>
            </button>
            <a class="navbar-brand" href="index.jsp">购物平台</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">首页</a></li>
                <li><a href="order.jsp">我的订单</a></li>
                <li class="active"><a href="userInfo.jsp">个人中心</a></li>
                <li><a href="friendLink.jsp">四宝介绍</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-sm">
                <%
                    if(session.getAttribute("username") == null){
                        out.println("<li class='active'><a href='login.jsp'>登录</a></li>");
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

<!--content-->
<div class="container">
    <div class="row thumbnail center col-sm-12">
        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">个人中心</h1>
        </div>
        <ul class="nav nav-tabs nav-justified" id="myTabs">
            <li class="active"><a href="#userHome">个人中心</a></li>
            <li><a href="#editInfo">信息修改</a></li>
            <li><a href="#editPassword">密码修改</a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="userHome">
                <br>
                <%
                    out.println("<ul class='list-group'>");
                    out.println("<li class='list-group-item'>用户名：" + username + "</li>");
                    out.println("<li class='list-group-item'>性别：" + sex + "</li>");
                    out.println("<li class='list-group-item'>电话：" + telephone + "</li>");
                    out.println("<li class='list-group-item'>地址：" + address + "</li>");
                    out.println("<li class='list-group-item'>邮箱：" + email + "</li>");
                    out.println("</ul>");
                %>
            </div>
            <div role="tabpanel" class="tab-pane" id="editInfo">
                <div class="col-sm-12">
                    <form class="form-horizontal caption" id="inputForm" data-toggle="validator" action="" method="post">
                        <div class="form-group">
                            <label for="inlineRadio1" class="col-sm-3 control-label">性别</label>
                            <div class="col-sm-6">
                                <label class="radio-inline">
                                    <input type="radio" name="sex" id="inlineRadio1" value="0" required <%= ("男".equals(sex)) ? "checked" : "" %>>男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" id="inlineRadio2" value="1" required <%= ("女".equals(sex)) ? "checked" : "" %>>女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="telephone" class="col-sm-3 control-label">电话</label>
                            <div class="col-sm-6">
                                <input type="tel" class="form-control" id="telephone" name="telephone"
                                       placeholder="电话号码" pattern="^[1][0-9]{10}$"
                                       value="<%=telephone%>" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address" class="col-sm-3 control-label">地址</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="address" name="address"
                                       placeholder="地址"
                                       value="<%=address%>" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="col-sm-3 control-label">邮箱</label>
                            <div class="col-sm-6">
                                <input type="email" class="form-control" id="email" name="email"
                                       placeholder="邮箱"
                                       value="<%=email%>" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-6">
                                <button type="submit" class="btn btn-success btn-block">修改信息</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="editPassword">
                <br>
                <div class="col-sm-12">
                    <form class="form-horizontal caption" id="inputForm2" data-toggle="validator" action="" method="post">
                        <div class="form-group">
                            <label for="password0" class="col-sm-3 control-label">原密码</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="password0" name="password0"
                                       placeholder="原密码" data-minlength="6"
                                       required>
                            </div>
                            <div class="help-block with-errors"></div>
                        </div>

                        <div class="form-group">
                            <label for="password1" class="col-sm-3 control-label">新密码</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="password1" name="password1"
                                       placeholder="新密码" data-minlength="6"
                                       data-error="至少6个字符！" required>
                                <div class="help-block with-errors"></div>
                                <span class="error-message" id="passwordError">新密码与原密码相同!</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password2" class="col-sm-3 control-label">确认密码</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="password2" name="password2"
                                       placeholder="确认密码"
                                       data-match="#password1" data-match-error="两次输入的密码不匹配！" required>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-6">
                                <button type="submit" id="submitButton" class="btn btn-success btn-block">修改密码</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
