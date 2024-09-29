<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="/resources/img/favicon.svg" />
    <title>Simple Admin Dashboards - Login</title>

    <!-- Common CSS -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/fonts/icomoon/icomoon.css" />

    <!-- Main and Login css -->
    <link rel="stylesheet" href="/resources/css/main.min.css" />

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <style>
        .btn-google {
            background-color: #db4437; /* Màu đỏ của Google */
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-google i {
            margin-right: 8px;
        }

        .btn-google:hover {
            background-color: #c1351d; /* Màu tối hơn khi hover */
            text-decoration: none;
        }


    </style>

</head>

<body class="login-bg">

<div class="container">
    <div class="login-screen row align-items-center">
        <div class="col-sm-12">
            <form action="/login" method="post">
                <div class="login-container">
                    <div class="row no-gutters">
                        <div class="col-xl-4 col-lg-5 col-md-6 col-sm-12">
                            <div class="login-box">
                                <a href="#" class="login-logo">
                                    <img src="/resources/img/logo-dark.svg" alt="Admin Dashboard" />
                                </a>
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="username">
                                            <i class="icon-account_circle"></i>
                                        </span>
                                    </div>
                                    <input type="text" name="username" class="form-control" placeholder="Username" aria-label="username"
                                           aria-describedby="username" value="${username}">
                                </div>
                                <div class="input-group mb-1">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="password">
                                            <i class="icon-verified_user"></i>
                                        </span>
                                    </div>
                                    <input type="password" name="password" class="form-control" placeholder="Password" aria-label="password"
                                           aria-describedby="Password" value="${password}">
                                </div>
                                <div>
                                    <label class="text-danger">${message}</label>
                                </div>
                                <div class="actions clearfix">
                                    <a href="/forgot-password">Quên mật khẩu?</a>
                                    <button type="submit" class="btn btn-primary">Login</button>
                                </div>
                                <div class="or"></div>
                                <div class="mt-4">
                                    <a href="/oauth2/authorization/google" class="btn btn-google btn-block">
                                        <i class="fab fa-google"></i> Đăng nhập bằng Google
                                    </a>
                                </div>

                                <div class="mt-4">
                                    <a href="/signup" class="additional-link">Bạn chưa có tài khoản? <span>Đăng kí ngay</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-8 col-lg-7 col-md-6 col-sm-12">
                            <div class="login-slider"></div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>

</html>
