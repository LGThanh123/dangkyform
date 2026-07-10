<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>

    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
            background:#f5f5f5;
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
        }

        .login-box{
            width:400px;
            background:#fff;
            padding:30px;
            border-radius:10px;
            box-shadow:0 0 15px rgba(0,0,0,0.2);
        }

        h2{
            text-align:center;
            margin-bottom:25px;
        }

        .btn-login{
            width:100%;
        }
    </style>
</head>

<body>

<div class="login-box">

    <h2>Đăng nhập</h2>

    <form method="post" action="LoginServlet">

        <%
            String error = (String) request.getAttribute("error");
            if(error != null){
        %>
            <div class="alert alert-danger">
                <%= error %>
            </div>
        <%
            }
        %>

        <div class="mb-3">
            <label class="form-label">Tài khoản</label>
            <input type="text"
                   class="form-control"
                   name="username"
                   placeholder="Nhập tài khoản"
                   required>
        </div>

        <div class="mb-3">
            <label class="form-label">Mật khẩu</label>
            <input type="password"
                   class="form-control"
                   name="password"
                   placeholder="Nhập mật khẩu"
                   required>
        </div>

        <button type="submit" class="btn btn-primary btn-login">
            Đăng nhập
        </button>

    </form>

</div>

</body>
</html>