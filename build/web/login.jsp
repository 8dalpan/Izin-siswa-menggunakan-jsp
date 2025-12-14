<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>

<body class="login-body">

<div class="login-box">
    <h2>Login</h2>

    <form action="proseslogin.jsp" method="post">
        <label>Username</label>
        <input type="text" name="username" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button type="submit" class="login-btn">Login</button>
    </form>

    <a href="register.jsp" class="login-link">Lupa Password</a>
</div>

</body>
</html>
