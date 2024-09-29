<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Danh mục</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .main-content {
            padding: 20px;
        }
        .card {
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            background-color: #fff;
        }
        .card-header {
            padding: 15px;
            background-color: #007bff;
            color: #000000;
            border-bottom: 1px solid #dee2e6;
            border-radius: 8px 8px 0 0;
        }
        .card-body {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .stats-widget {
            width: 100%;
            text-align: center;
        }
        .stats-widget-header {
            font-size: 30px;
            margin-bottom: 15px;
        }
        .stats-widget-body ul {
            list-style-type: none;
            padding: 0;
            width: 100%;
        }
        .stats-widget-body ul li {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #dee2e6;
        }
        .stats-widget-body ul li:last-child {
            border-bottom: none;
        }
        .title {
            font-size: 16px;
            color: #495057;
            margin-right: 20px;
        }
        .total {
            font-size: 28px;
            font-weight: bold;
            color: #007bff;
        }
        .row.gutters {
            margin-left: -15px;
            margin-right: -15px;
        }
        .col-md-4, .col-sm-6 {
            padding-left: 15px;
            padding-right: 15px;
        }
        .chart-container {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="main-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>Thống kê Tài khoản</h3>
                </div>
            </div>
            <div class="row gutters">
                <!-- Tổng Nhân viên -->
                <div class="col-md-4 col-sm-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stats-widget">
                                <div class="stats-widget-header">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="stats-widget-body">
                                    <ul>
                                        <li>
                                            <h6 class="title mr-2">Tổng Nhân viên</h6>
                                            <h4 class="total">${numberStaff}</h4>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Nhân viên đang làm -->
                <div class="col-md-4 col-sm-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stats-widget">
                                <div class="stats-widget-header">
                                    <i class="fas fa-user-check"></i>
                                </div>
                                <div class="stats-widget-body">
                                    <ul>
                                        <li>
                                            <h6 class="title mr-2">Nhân viên đang làm</h6>
                                            <h4 class="total">${numberStatusActivityStaff}</h4>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Nhân viên đã nghỉ -->
                <div class="col-md-4 col-sm-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stats-widget">
                                <div class="stats-widget-header">
                                    <i class="fas fa-user-times"></i>
                                </div>
                                <div class="stats-widget-body">
                                    <ul>
                                        <li>
                                            <h6 class="title mr-2">Nhân viên đã nghỉ</h6>
                                            <h4 class="total">${numberStatusBlockStaff}</h4>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row gutters">
                <!-- Tổng Khách hàng -->
                <div class="col-md-4 col-sm-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stats-widget">
                                <div class="stats-widget-header">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="stats-widget-body">
                                    <ul>
                                        <li>
                                            <h6 class="title mr-2">Tổng Khách hàng</h6>
                                            <h4 class="total">${numberCustomer}</h4>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Khách hàng đang hoạt động -->
                <div class="col-md-4 col-sm-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stats-widget">
                                <div class="stats-widget-header">
                                    <i class="fas fa-user-check"></i>
                                </div>
                                <div class="stats-widget-body">
                                    <ul>
                                        <li>
                                            <h6 class="title mr-2">Khách hàng đang hoạt động</h6>
                                            <h4 class="total">${numberStatusActivityCustomer}</h4>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Khách hàng bị khóa -->
                <div class="col-md-4 col-sm-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stats-widget">
                                <div class="stats-widget-header">
                                    <i class="fas fa-user-times"></i>
                                </div>
                                <div class="stats-widget-body">
                                    <ul>
                                        <li>
                                            <h6 class="title mr-2">Khách hàng bị khóa</h6>
                                            <h4 class="total">${numberStatusBlockCustomer}</h4>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row gutters">
                <!-- Biểu đồ tỷ lệ giới tính -->
                <div class="col-md-12">
                    <div class="card chart-container">
                        <div class="card-header">
                            <h3>Biểu đồ Tài khoản mới trong 30 ngày gần nhất</h3>
                        </div>
                        <div class="card-body">
                            <canvas id="createDateChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>


            <div class="row gutters">
                <!-- Biểu đồ tỷ lệ giới tính -->
                <div class="col-md-6">
                    <div class="card chart-container">
                        <div class="card-header">
                            <h4>Biểu đồ Tỷ lệ Giới tính Khách hàng(%)</h4>
                        </div>
                        <div class="card-body">
                            <canvas id="genderChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Biểu đồ độ tuổi -->
                <div class="col-md-6">
                    <div class="card chart-container">
                        <div class="card-header">
                            <h4>Biểu đồ Tỉ lệ Độ tuổi Khách hàng(%)</h4>
                        </div>
                        <div class="card-body">
                            <canvas id="ageChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- jQuery first, then Tether, then other JS. -->
<script src="<c:url value='/resources/js/jquery.js'/>"></script>
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/resources/vendor/unifyMenu/unifyMenu.js'/>"></script>
<script src="<c:url value='/resources/vendor/onoffcanvas/onoffcanvas.js'/>"></script>
<script src="<c:url value='/resources/js/moment.js'/>"></script>

<!-- Common JS -->
<script src="<c:url value='/resources/js/common.js'/>"></script>

<!-- Chart JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>

    const ctxCreateDate = document.getElementById('createDateChart').getContext('2d');


    // Số liệu từ server (JSON string)
    const statisticCreateDateCustomerJson = '${statisticCreateDateCustomerJson}';

    // Parse JSON string into JavaScript object
    const statisticCreateDateCustomer = JSON.parse(statisticCreateDateCustomerJson);
    console.log(statisticCreateDateCustomer);


    // Cập nhật biểu đồ ngày tạo
    new Chart(ctxCreateDate, {
        type: 'line',
        data: {
            labels: statisticCreateDateCustomer.map(item => item.label),
            datasets: [{
                label: 'Số lượng',
                data: statisticCreateDateCustomer.map(item => item.value),
                backgroundColor: 'rgba(54, 162, 235, 0.2)', // Màu nền với độ mờ
                borderColor: '#1e88e5',
                borderWidth: 2,
                fill: true, // Bật chế độ tô màu
                tension: 0.4, // Làm đường cong
            }],
        },
        options: {
            plugins: {

            },
            scales: {
                x: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Ngày Tạo'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Số lượng'
                    }
                }
            }
        }
    });





    // Biểu đồ tỷ lệ giới tính
    const ctxGender = document.getElementById('genderChart').getContext('2d');

    // Số liệu từ server (JSON string)
    const statisticGenderCustomerJson = '${statisticGenderCustomerJson}';

    // Parse JSON string into JavaScript object
    const statisticGenderCustomer = JSON.parse(statisticGenderCustomerJson);
    console.log(statisticGenderCustomer);

    new Chart(ctxGender, {
        type: 'doughnut',
        data: {
            labels: statisticGenderCustomer.map((data) => data.label),
            datasets: [{
                data: statisticGenderCustomer.map((data) => data.value),
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
            }],
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom',
                }

            },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        let label = context.label || '';
                        if (label) {
                            label += ': ';
                        }
                        if (context.raw !== null) {
                            label += context.raw + '%';
                        }
                        return label;
                    }
                }
            },
        }
    });

    // Biểu đồ tỷ lệ Độ tuổi
    const ctxAge = document.getElementById('ageChart').getContext('2d');

    // Số liệu từ server (JSON string)
    const statisticAgeCustomerJson = '${statisticAgeCustomerJson}';

    // Parse JSON string into JavaScript object
    const statisticAgeCustomer = JSON.parse(statisticAgeCustomerJson);

    new Chart(ctxAge, {
        type: 'doughnut',
        data: {
            labels: statisticAgeCustomer.map((data) => data.label),
            datasets: [{
                data: statisticAgeCustomer.map((data) => data.value),
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
            }],
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom',
                },
            },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        let label = context.label || '';
                        if (label) {
                            label += ': ';
                        }
                        if (context.raw !== null) {
                            label += context.raw + '%';
                        }
                        return label;
                    }
                }
            },
        }
    });
</script>

</body>
</html>
