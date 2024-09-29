<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Weekly Statistics</title>
    <!-- Chartist.js Library -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chartist/dist/chartist.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chartist/dist/chartist.min.js"></script>
    <!-- Bootstrap for styling (Optional) -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chartist Tooltip Plugin -->
    <script src="https://cdn.jsdelivr.net/chartist-plugin-tooltips@0.0.18/dist/chartist-plugin-tooltip.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/chartist-plugin-tooltips@0.0.18/dist/chartist-plugin-tooltip.css">
    <style>
        body {
            padding-top: 20px;
            padding-bottom: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .chart-container {
            position: relative;
            margin: auto;
            height: 400px;
            width: 100%;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>${test}</h1>
    <h1>Weekly Order Statistics</h1>
    <div class="chart-container">
        <div class="custom-area-chart4"></div>
    </div>

    <i class="material-icons">people</i>
    <i class="material-icons">group</i>
    <i class="fas fa-user-tie"></i>
    <i class="fas fa-users-cog"></i>

</div>

    <!-- Chartist JS -->
    <script src="/resources/vendor/chartist/js/chartist.min.js"></script>
    <script src="/resources/vendor/chartist/js/chartist-tooltip.js"></script>


<script>
    // Dữ liệu từ server
    const weeklyOrderCounts = JSON.parse('${weeklyOrderCounts}');

    // Chuyển đổi dữ liệu để phù hợp với định dạng Chartist
    const labels = weeklyOrderCounts.map(item => item.week);
    const series = [weeklyOrderCounts.map(item => item.count)];

    new Chartist.Line('.custom-area-chart4', {
        labels: labels,
        series: series
    }, {
        low: 0,
        lineSmooth: true,
        showArea: true,
        showLine: true,
        showPoint: true,
        showLabel: false,
        fullWidth: true,
        height: "190px",
        chartPadding: {
            right: 10,
            left: 10,
            bottom: -20,
            top: 20
        },
        axisX: {
            offset: 0,
            showGrid: false,
            showLabel: true, // Sửa đổi tùy thuộc vào yêu cầu của bạn
        },
        axisY: {
            offset: 0,
            showGrid: false,
            showLabel: true, // Sửa đổi tùy thuộc vào yêu cầu của bạn
        },
        plugins: [
            Chartist.plugins.tooltip() // Sử dụng plugin tooltip
        ]
    });
</script>
</body>
</html>
