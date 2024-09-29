<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Trang đăng ký tài khoản" />
    <meta name="keywords" content="Signup, Đăng ký" />
    <meta name="author" content="Bootstrap Gallery" />
    <link rel="shortcut icon" href="/resources/img/favicon.svg" />
    <title>Đăng ký</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <style>
        .container {
            margin-top: 50px;
        }
        .login-box {
            background-color: #f7f7f7;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .login-box:hover {
            transform: scale(1.02);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .login-logo img {
            width: 100px;
            display: block;
            margin: 0 auto 20px;
        }
        .input-group-text {
            background-color: #007bff;
            color: white;
            width: 40px;
            text-align: center;
        }
        .input-group-text i {
            font-size: 16px;
        }
        .form-control {
            height: 45px;
            border-radius: 10px;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            height: 45px;
            border-radius: 10px;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .additional-link {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
        .additional-link a {
            color: #007bff;
            text-decoration: none;
        }
        .additional-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="login-box">
                <a href="/user/home" class="login-logo">
                    <img src="/resources/img/logo-dark.svg" />
                </a>
                <h2 class="text-center">Đăng ký tài khoản</h2>
                <form:form method="post" action="/signup" id="signupForm" modelAttribute="customer">
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="customerName">
                                    <i class="fa fa-user"></i>
                                </span>
                            </div>
                            <c:choose>
                                <c:when test="${not empty sessionScope.nameSignup}">
                                    <form:input path="customerName" class="form-control" placeholder="Họ và tên" aria-label="customerName" aria-describedby="customerName" required="true" value="${sessionScope.nameSignup}"/>
                                </c:when>
                                <c:otherwise>
                                    <form:input path="customerName" class="form-control" placeholder="Họ và tên" aria-label="customerName" aria-describedby="customerName" required="true"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="account.email">
                                    <i class="fa fa-envelope"></i>
                                </span>
                            </div>
                            <c:choose>
                                <c:when test="${not empty sessionScope.emailSignup}">
                                    <form:input path="account.email" class="form-control" placeholder="Email" aria-label="account.email" aria-describedby="account.email" value="${sessionScope.emailSignup}" readonly="true"/>
                                </c:when>
                                <c:otherwise>
                                    <form:input path="account.email" class="form-control" placeholder="Email" aria-label="account.email" aria-describedby="account.email" required="true"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="account.password">
                                    <i class="fa fa-lock"></i>
                                </span>
                            </div>
                            <form:input path="account.password" type="password" class="form-control" placeholder="Mật khẩu" aria-label="account.password" aria-describedby="account.password" required="true"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="confirmPwd">
                                    <i class="fa fa-lock"></i>
                                </span>
                            </div>
                            <input type="password" name="confirmPwd" class="form-control" placeholder="Xác nhận mật khẩu" aria-label="confirmPwd" aria-describedby="confirmPwd" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="dateOfBirth">
                                    <i class="fa fa-calendar"></i>
                                </span>
                            </div>
                            <form:input path="dateOfBirth" type="date" class="form-control" placeholder="Ngày sinh" aria-label="dateOfBirth" aria-describedby="dateOfBirth" required="true"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="gender">
                                    <i class="fa fa-venus-mars"></i>
                                </span>
                            </div>
                            <form:select path="gender" class="form-control" aria-label="gender" aria-describedby="gender" required="true">
                                <option value="" disabled selected>Chọn giới tính</option>
                                <option value="1">Nam</option>
                                <option value="0">Nữ</option>
                                <option value="2">Khác</option>
                            </form:select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="account.phoneNumber">
                                    <i class="fa fa-phone"></i>
                                </span>
                            </div>
                            <form:input path="account.phoneNumber" class="form-control" placeholder="Số điện thoại" aria-label="account.phoneNumber" aria-describedby="account.phoneNumber" required="true"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary btn-block">Đăng ký</button>
                    </div>
                </form:form>
                <div class="additional-link">
                    <a href="/login">Đã có tài khoản? Đăng nhập ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    $(document).ready(function() {
        $('#signupForm').on('submit', function(event) {
            event.preventDefault();

            const formData = new FormData(this);
            $.ajax({
                type: "POST",
                url: "/signup",
                data: formData,
                processData: false,
                contentType: false,
                headers: {
                    "Accept": "application/json"
                },
                success: function() {
                    Swal.fire({
                        icon: 'success',
                        title: 'Đăng ký thành công',
                        text: 'Bạn đã đăng ký thành công!',
                        confirmButtonText: 'Chuyển đến trang chủ'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = "/user/home";
                        }
                    });
                },
                error: function(xhr) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Cảnh báo',
                        text: xhr.responseText,
                        confirmButtonText: 'OK'
                    });
                }
            });
        });
    });
</script>
</body>
</html>
