
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>人事管理系统</title>
	<link href="https://v4.bootcss.com/docs/4.3/dist/css/bootstrap.css" rel="stylesheet">
    <link href="/static/css/elementUI.css" rel="stylesheet">
   <script src="/static/js/bootstrap.min.js"></script>
   <script src="/static/js/vue.js"></script>
    <script src="/static/js/index.js"></script>
    <style>
		*{
            margin: 0;
            padding: 0;
		}
        html, body {
            width: 100%;
            height: 100%;
        }
        body{
            display: flex;
            flex-direction: column;
        }
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }
    </style>
    <link href="https://v4.bootcss.com/docs/4.3/examples/pricing/pricing.css" rel="stylesheet">
</head>
<body>
<div id="app" class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm"  style="height: 60px;margin-top: 15px;">
    <h5 class="my-0 mr-md-auto font-weight-normal">人事管理系统</h5>
    <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect" id="ul">
        <el-menu-item index="1"><a href="index_home" target="iframe">主页</a></el-menu-item>
        <el-menu-item index="2">个人介绍</el-menu-item>
        <el-menu-item index="3"><a href="introduce_system" target="iframe">系统介绍</a></el-menu-item>
        <el-menu-item index="4">关于我们</el-menu-item>
    </el-menu>

</div>
<div style="flex-grow: 1;">
    <iframe id="iframe" style="margin: 0;padding: 0px; border: 0;" src="index_home" name="iframe" align="center" scrolling="yes" width="100%" height="100%" frameborder="no" ></iframe>
</div>
<script>
    var vm = new Vue({
        el:"#app",
        data:{

        }
    })
</script>
</body>
</html>
