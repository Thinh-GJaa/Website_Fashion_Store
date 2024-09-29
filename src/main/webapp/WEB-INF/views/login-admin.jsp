<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Simple Admin Panels" />
    <meta name="keywords"
          content="Login, Unify Login, Admin, Dashboard, Bootstrap4, Sass, CSS3, HTML5, Responsive Dashboard, Responsive Admin Template, Admin Template, Best Admin Template, Bootstrap Template, Themeforest" />
    <meta name="author" content="Bootstrap Gallery" />
    <link rel="canonical" href="https://www.bootstrap.gallery/">
    <meta property="og:url" content="https://www.bootstrap.gallery">
    <meta property="og:title" content="Admin Templates - Dashboard Templates | Bootstrap Gallery">
    <meta property="og:description" content="Marketplace for Bootstrap Admin Dashboards">
    <meta property="og:type" content="Website">
    <meta property="og:site_name" content="Bootstrap Gallery">
    <link rel="shortcut icon" href="/resources/img/favicon.svg" />
    <title>Simple Admin Dashboards - Login</title>

    <!-- Common CSS -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/fonts/icomoon/icomoon.css" />

    <!-- Mian and Login css -->
    <link rel="stylesheet" href="/resources/css/main.min.css" />

</head>

<body class="login-bg">

<div class="container">
    <div class="login-screen row align-items-center">
        <div class="col-sm-12">
            <form action="/login-admin" method="post">
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
                                    <input type="text" class="form-control" placeholder="Username" aria-label="username"
                                           aria-describedby="username" name="username">
                                </div>
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
												<span class="input-group-text" id="password">
													<i class="icon-verified_user"></i>
												</span>
                                    </div>
                                    <input type="password" class="form-control" placeholder="Password" aria-label="Password"
                                           aria-describedby="Password" name="password">
                                </div>
                                <div>
                                    <label class="text-danger">${message}</label>
                                </div>
                                <div class="actions clearfix">
                                    <a href="/forgot-password">Quên mật khẩu?</a>
                                    <button type="submit" class="btn btn-primary">Đăng nhập</button>
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
