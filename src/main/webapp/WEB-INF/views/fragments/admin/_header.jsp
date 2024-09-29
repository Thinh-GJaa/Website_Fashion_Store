<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<header class="app-header">
    <div class="container-fluid">
        <div class="row ">
            <div class="col-md-6 col-sm-8 col-8">
                <a href="index.html" class="logo">
                    <img src="/resources/img/logo.svg" alt="Quality Admin Dashboards">
                </a>
                <a class="mini-nav-btn" href="#" id="app-side-mini-toggler">
                    <i class="icon-sort"></i>
                </a>
                <a href="#app-side" data-toggle="onoffcanvas" class="onoffcanvas-toggler" aria-expanded="true">
                    <i class="icon-chevron-thin-left"></i>
                </a>
            </div>
            <div class="col-md-6 col-sm-4 col-4">
                <ul class="header-actions">


                    <li class="dropdown">
                        <a href="#" id="userSettings" class="user-settings" data-toggle="dropdown" aria-haspopup="true">
                            <img class="avatar" src="/resources/img/user.png" alt="Admin Dashboards">
                            <i class="icon-chevron-small-down"></i>
                        </a>
                        <div class="dropdown-menu lg dropdown-menu-right" aria-labelledby="userSettings">
                            <ul class="user-settings-list">
                                <li>
                                    <a href="/admin/profile">
                                        <div class="icon">
                                            <i class="icon-account_circle"></i>
                                        </div>
                                        <p>Profile</p>
                                    </a>
                                </li>

                            </ul>
                            <div class="logout-btn">
                                <a href="/admin/logout" class="btn btn-primary">Logout</a>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>
