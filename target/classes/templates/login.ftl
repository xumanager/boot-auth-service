<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Title</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://unpkg.com/element-ui@2.13.0/lib/theme-chalk/index.css">
    <script src="/static/js/vue.js"></script>
    <script src="/static/js/newindex.js"></script>
    <script src="/static/js/vue-axios.js"></script>
    <script src="/static/js/vue-router.js"></script>
    <script src="/static/js/jquery-1.11.0.js"></script>
    <style type="text/css">
        *{
            margin:0
        }
        html{
            width: 100%;
            height: 100%;
        }
        body{
            width: 100%;
            height: 100%;
            background: url("/static/image/background.jpg") ;
            background-size: 100% 100%;
            overflow: hidden;
            display: flex;
            justify-content: center;
        }
        #app{

            display: flex;
            flex-direction: column;
            width: 400px;
            height: 300px;
        }
        #header{
            margin-top: 100px;
            display: flex;
            flex-direction: row;
        }
        #header a{
            display: flex;
            height: 50px;
            flex-grow: 1;
            text-decoration: none;
            font-size: 16px;
            justify-content: center;
            align-items: center;
            color: #808080;
            background: #fff;
            border-bottom: #808080 solid 2px;
        }
        .router-link-active{
            font-weight: 800;
        }
        .v-enter,
        .v-leave-active{
            opacity: 0;
            transform:  rotateY(80deg);
        }

        .v-enter-active,
        .v-leave-active{
            transition: all 0.3s ease;
        }
        #main{
            flex-grow: 1;
        }
        .mydiv{
            width: 100%;
            height: 100%;
            display: flex;
            background: #fff;
            opacity: 0.98;
            padding: 20px 40px;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        #main:hover,#main:focus{
            box-shadow: 3px 5px 10px 0 #808080;
        }
    </style>
</head>
<body>
<div id="app">
    <div id="header">
        <router-link to="/login" style=" border-top-left-radius:25px;"><span>登录</span></router-link>
        <router-link to="/register" >注册</router-link>
    </div>
    <div id="main" >
        <transition mode="out-in">
            <router-view  @messagesuccess="messagedialogsuccess"  @messagefail="messagedialogfail"></router-view>
        </transition>
    </div>



</div>
<template id="loginTemplate">
    <div  style="height:300px;border-bottom-right-radius:25px;">
        <form action="/login" method="post" id="loginform" class="mydiv" >
            <h4 style="text-align: center">系统登录</h4>
            <br>
            <el-input
                    placeholder="请输入用户名"
                    v-model="username" id="username" name="username" style="width: 250px">
                <i slot="prefix" class="el-input__icon el-icon-user-solid"></i>

            </el-input>
            <br>
            <el-input
                    placeholder="请输入密码"
                    type="password"
                    v-model="password" id="password" name="password" style="width: 250px">
                <i slot="prefix" class="el-input__icon el-icon-lock"></i>
            </el-input>
            <br>
            <button type="button" class="btn btn-success" style="width: 100px;" @click="login" >登录</button>
        </form>
    </div>
</template>

<template id="registerTemplate">
    <div class="mydiv" style="height: 380px;border-bottom-right-radius:25px;" >
        <form action="/login" method="post" id="registform" class="mydiv">
            <h4 style="text-align: center;">系统注册</h4>
            <br>
            <el-input
                    placeholder="用户名"
                    v-model="username" id="username" name="username">
                <i slot="prefix" class="el-input__icon el-icon-user-solid"></i>
            </el-input>
            <br>
            <el-input
                    placeholder="密码"
                    type="password"
                    v-model="password" id="password" name="password">
                <i slot="prefix" class="el-input__icon el-icon-lock"></i>
            </el-input>
            <br>
            <el-input
                    placeholder="手机号码"
                    v-model="phone" id="phone" name="phone">
                <i slot="prefix" class="el-input__icon el-icon-phone"></i>
            </el-input>

            <br>
            <el-input
                    placeholder="邮箱"
                    type="email"
                    v-model="email" id="email" name="email">
                <i slot="prefix" class="el-input__icon el-icon-message"></i>
            </el-input>
            <br>
            <div style="display: flex;flex-direction: row;justify-content: center;align-items: center">
                <button type="reset" class="btn" style="width: 100px;" @click="rreset">重置</button>
                <button type="button" class="btn btn-warning" style="width: 100px;margin-left: 20px"  @click="regist" >注册</button>
            </div>

        </form>
    </div>
</template>
<script>
    var login = {
        template:'#loginTemplate',
        data(){
            return{
                username : '',
                password : ''
            }
        },
        methods:{

            login(){
                //检验数据
                if(this.username == undefined || this.username == ""){
                    this.$emit('messagefail',"用户名未输入");
                }else if(this.password == undefined || this.password == ""){
                    this.$emit('messagefail',"密码未输入");
                }else if(this.username.indexOf(" ") >=0 || this.password.indexOf(" ") >=0 ) {
                    this.$emit('messagefail',"用户名或者密码含有空格");
                }else{
                    //校验完成，直接提交
                    axios({
                        methods: 'post',
                        url: '/axiosLogin',
                        params: {
                            username: this.username,
                            password: this.password
                        }
                    }).then((request) =>{
                        var datas = request.data;
                        if(datas.status === "1"){
                            this.$emit('messagesuccess', "登录成功");
                            //提交表单
                            setTimeout(this.submit,1000);
                        }else{
                            this.$emit('messagefail', datas.message);
                        }
                    }).catch(function (error) {
                        this.$emit('messagefail', "非正常失败");
                    })
                }
            },
            submit(){
                $("#loginform").submit();
            },
        }
    }
    var register = {
        template:'#registerTemplate',
        data(){
            return{
                username : '',
                password : '',
                phone:'',
                email:''
            }
        },
        methods: {
            rreset(){
                this.username = "";
                this.password = "";
                this.phone = "";
                this.email = "";
            },
            regist(){
                //检验数据
                if(this.username == undefined || this.username == ""){
                    this.$emit('messagefail',"用户名未输入");
                }else if(this.password == undefined || this.password == ""){
                    this.$emit('messagefail',"密码未输入");
                }else if(this.phone == undefined || this.phone == ""){
                    this.$emit('messagefail',"手机号码未输入");
                }else if(this.email == undefined || this.email == ""){
                    this.$emit('messagefail',"邮箱未输入");
                }else if(this.username.indexOf(" ") >=0 || this.password.indexOf(" ") >=0 || this.phone.indexOf(" ") >=0 ||this.email.indexOf(" ") >=0 ) {
                    this.$emit('messagefail',"输入有空格，请认真检查");
                }else{
                    //校验完成，直接提交
                    axios({
                        methods: 'post',
                        url: '/axiosRegist',
                        params: {
                            username: this.username,
                            password: this.password,
                            phone : this.phone,
                            email : this.email
                        }
                    }).then((request) =>{
                        var datas = request.data;
                    if(datas.status === "1"){
                        this.$emit('messagesuccess', "注册成功");
                        this.username = "";
                        this.password = "";
                        this.phone = "";
                        this.email = "";
                        this.phone = "";
                    }else{
                        this.$emit('messagefail', datas.message);
                    }
                }).catch(function (error) {
                        this.$emit('messagefail', "非正常注册失败");
                    })
                }
            },
            submit(){
                $("#registform").submit();
            },
        }
    }

    var routerObj = new VueRouter({
        routes:[
            {path:'/',redirect:'login'},
            {path:'/login',component:login},
            {path:'/register',component:register}
        ]
    })

    var vm = new Vue({
        el:"#app",
        data:{
            add : "asd"
        },
        methods:{
            messagedialogsuccess(val) {
                this.$message({
                    type: 'success',
                    message: val   });
             },
            messagedialogfail(val) {
                this.$message({
                    type: 'info',
                    message: val   });
            }
        },
        router:routerObj,

    })
</script>
</body>
</html>
