<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>权限欢迎页面</title>

    <link href="https://v4.bootcss.com/docs/4.3/dist/css/bootstrap.css" rel="stylesheet">
    <link href="/static/css/elementUI.css" rel="stylesheet">
    <script src="/static/js/vue.js"></script>
    <script src="/static/js/index.js"></script>
    <style>
        body,html{
            width: 100%;
            height: 100%;
            padding: 13px 20px;
            overflow: hidden;
        }
        .el-carousel__item{
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .el-carousel__item h3 {
            color: #808080;
            font-weight: 800;
            font-size: 50px;
            margin: 0;
            padding: 10px 25px;
            opacity: 0.85;
            background: #fff;
            border-radius: 9px;
            text-align: center;
        }
        #app{
            width: 100%;
            height: 100%;
        }
        .el-carousel__item:nth-child(2n) {
            background-color: #99a9bf;
        }

        .el-carousel__item:nth-child(2n+1) {
            background-color: #d3dce6;
        }
        .div{
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .el-carousel__container{
            height: 350px;
        }
    </style>
</head>
<body>
<div id="app" >
    <el-container>
        <el-container>
            <el-main >
                <el-carousel :interval="4000" type="card" >
                    <el-carousel-item v-for="item in menu" :key="item" >
                        <div class="div" :style="{'background': 'url('+item.url+') ','background-size':' 100% 100%'}"  >
                            <h3 class="medium">{{ item.name }}</h3>
                        </div>
                    </el-carousel-item>
                </el-carousel>

            </el-main>
            <el-aside width="300px" style="margin-left: 50px;">

                <el-collapse style="overflow: hidden;" >
                    <el-collapse-item title="用户管理 User" name="1">
                        <div>注册系统的用户集中在此处</div>
                        <div>允许用户信息的增删改查，为用户绑定指定员工信息，可分配对应角色权限给用户</div>
                        <div style="color:red;">对用户信息的操作不影响员工信息以及角色信息</div>
                    </el-collapse-item>
                    <el-collapse-item title="角色管理 Role" name="2">
                        <div>系统管理所有的权限角色</div>
                        <div>无权限分配操作，仅对角色信息进行增删改查</div>
                    </el-collapse-item>
                    <el-collapse-item title="资源管理 Resource" name="3">
                        <div>管理系统所有页面操作相关权限</div>
                        <div>可赋予指定用户指定权限</div>
                        <div style="color:red;">注意：操作需谨慎，影响系统运行！</div>
                    </el-collapse-item>
                    <#--<el-collapse-item title="申请请求 Request" name="4">-->
                        <#--<div>管理系统用户对权限的申请</div>-->
                    <#--</el-collapse-item>-->
                </el-collapse>

            </el-aside>

        </el-container>
    </el-container>




</div>
<script>
    new Vue({
        el:'#app',
        data:{
            menu:[
                {
                    id:'1',
                    name:'用户管理',
                    url:'/static/image/back1.jpg',
                },
                {
                    id:'2',
                    name:'角色管理',
                    url:'/static/image/back4.jpg',
                },
                {
                    id:'3',
                    name:'资源管理',
                    url:'/static/image/back3.jpg',
                },
                // {
                //     id:'4',
                //     name:'申请请求',
                //     url:'/static/image/back2.jpg',
                // },
            ]
        }
    })
</script>
</body>
</html>
