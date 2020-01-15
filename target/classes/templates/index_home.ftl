
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v3.8.6">
    <title>权限管理系统</title>

	<link href="https://v4.bootcss.com/docs/4.3/dist/css/bootstrap.css" rel="stylesheet">
	<link href="/static/css/elementUI.css" rel="stylesheet">
	<script src="/static/js/vue.js"></script>
	<script src="/static/js/index.js"></script>
      <script src="/static/js/vue-axios.js"></script>
      <script src="/static/js/jquery-1.11.0.js"></script>
    <style>
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
	  #ul{
		  display: flex;
		  flex-direction: row;
		  justify-content: center;
	  }
      .el-menu-item{
          display: flex;
          flex-direction: column;
          justify-content: center;
      }
      .el-badge{
          height: 30px;
          display: flex;
          flex-direction: column;
          justify-content: center;
      }
      .el-badge button{
          display: block;
          font-size: 14px;
          color: #909399;
      }
    a{
        text-decoration: none;
    }
    </style>
    <link href="https://v4.bootcss.com/docs/4.3/examples/pricing/pricing.css" rel="stylesheet">
  </head>
  <body>
	<div id="app">
		
		
	
	<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
	  <h1 class="display-4">welcome <@shiro.authenticated><span style="color:#8080ff;"><@shiro.principal/></span></@shiro.authenticated></h1>
	  <p class="lead">Welcome to the rights management system.Choose what you want to explore.</p>
	</div>

	<div class="container">
    <@shiro.authenticated>
        <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal"  id="ul">

            <@shiro.hasAnyRoles  name="normal">
                 <el-menu-item index="1" >个人主页</el-menu-item>
                 <el-menu-item index="2">
                     <el-badge :value="messageSize" class="item">
                         <el-button size="small" ><a href="normal/message/index">我的消息</a></el-button>
                     </el-badge>

                 </el-menu-item>
                 <el-menu-item index="4">公告中心</el-menu-item>
                 <el-submenu index="3">
                    <template slot="title">用户中心</template>
                    <el-menu-item index="3-1" @click="dialogUpdateVisible = true">修改密码</el-menu-item>
                    <el-menu-item index="3-2" @click="logout">退出登录</el-menu-item>
                 </el-submenu>
            </@shiro.hasAnyRoles >

          </el-menu>
          <el-menu id="ul"
            :default-active="activeIndex2"
            class="el-menu-demo"
            mode="horizontal"
            @select="handleSelect"
            background-color="#545c64"
            text-color="#fff"
            active-text-color="#ffd04b">
              <@shiro.hasAnyRoles  name="employee">
                      <el-menu-item index="5"><a href="emp/clockIn">打卡记录</a></el-menu-item>
                      <el-menu-item index="6"><a href="emp/applyAuth">申请权限</a></el-menu-item>
              </@shiro.hasAnyRoles >
            <@shiro.hasAnyRoles  name="account">
                     <el-menu-item index="2"><a href="account/index">财务管理</a></el-menu-item>
            </@shiro.hasAnyRoles >
              <@shiro.hasAnyRoles  name="hr">
                     <el-menu-item index="3"><a href="company/index">公司管理</a></el-menu-item>
              </@shiro.hasAnyRoles >
            <@shiro.hasAnyRoles  name="auth">
                      <el-menu-item index="4"><a href="auth/index">权限管理</a></el-menu-item>
            </@shiro.hasAnyRoles >


          </el-menu>
    </@shiro.authenticated>
    <@shiro.notAuthenticated>
        <p class="lead" style="text-align: center">You can only operate the system after logging in.</p>
        <div style="display: flex;align-items: center;justify-content: center">
            <a class="btn btn-outline-primary" style="width:120px;" href="/loginUI">Logging in</a>
        </div>

    </@shiro.notAuthenticated>
        <footer class="pt-4 my-md-5 pt-md-5 border-top" >
            <div class="row">
                <div class="col-12 col-md">
                    <small class="d-block mb-3 text-muted">&copy; 2019-2020</small>
                </div>
                <div class="col-6 col-md">
                    <h5>Effect</h5>
                    <ul class="list-unstyled text-small">
                        <li><a class="text-muted" href="#">Manage personal details </a></li>
                        <li><a class="text-muted" href="#">Manage employee</a></li>
                        <li><a class="text-muted" href="#">Manage account</a></li>
                        <li><a class="text-muted" href="#">Message communication</a></li>
                        <li><a class="text-muted" href="#">Authorization</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md">
                    <h5>Purpose</h5>
                    <ul class="list-unstyled text-small">
                        <li><a class="text-muted" href="#">Study java</a></li>
                        <li><a class="text-muted" href="#">Practice skills</a></li>
                        <li><a class="text-muted" href="#">Framework test</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md">
                    <h5>Contact</h5>
                    <ul class="list-unstyled text-small">
                        <li><a class="text-muted" href="#">QQ：296175871</a></li>
                        <li><a class="text-muted" href="#">Email：296175871@qq.com</a></li>
                    </ul>
                </div>

        </div>
        <el-dialog title="修改密码" :visible.sync="dialogUpdateVisible" width="25%">
            <el-form :model="form">
                <el-form-item style="display: flex;flex-direction: row;justify-content: center">
                    <el-input type="text" v-model="form.phone" placeholder="手机号码" autocomplete="off" style="width: 200px"></el-input>
                </el-form-item>
                <el-form-item  style="display: flex;flex-direction: row;justify-content: center">
                    <el-input type="password" v-model="form.oldpassword"  placeholder="旧密码" autocomplete="off" style="width: 200px"></el-input>
                </el-form-item>
                <el-form-item  style="display: flex;flex-direction: row;justify-content: center">
                    <el-input type="password" v-model="form.newpassword1" placeholder="新密码"  autocomplete="off" style="width: 200px"></el-input>
                </el-form-item>
                <el-form-item  style="display: flex;flex-direction: row;justify-content: center">
                    <el-input type="password" v-model="form.newpassword2" placeholder="确定密码"  autocomplete="off" style="width: 200px"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogUpdateVisible = false">取 消</el-button>
                <el-button type="warning" @click="handlePasswordUpdate">确定修改</el-button>
            </div>
        </el-dialog>
        </footer>
	</div>
	</div>
	<script>
		new Vue({
			el:"#app",
			data:{
                dialogUpdateVisible : false,
                form:{
                    phone:'',
                    oldpassword:'',
                    newpassword1:'',
                    newpassword2:''
                },
                messageSize : ''
			},
            methods:{
                handlePasswordUpdate(){
                    if(this.form.phone == undefined || this.form.phone == ""){
                        this.messageDialog("info","手机号码未输入");
                    }else if(this.form.oldpassword == undefined || this.form.oldpassword == ""){
                        this.messageDialog("info","旧密码未输入");
                    }else if(this.form.newpassword1== undefined || this.form.newpassword1 == ""){
                        this.messageDialog("info","新密码未输入");
                    }else if(this.form.newpassword2== undefined || this.form.newpassword2 == ""){
                        this.messageDialog("info","确认密码未输入");
                    }else if(this.form.newpassword2.indexOf(" ") >=0 || this.form.newpassword1.indexOf(" ") >=0 || this.form.oldpassword.indexOf(" ") >=0 ||this.form.phone.indexOf(" ") >=0 ) {
                        this.messageDialog("info","输入有空格，请重新输入");
                    }else if(this.form.newpassword2 === this.form.newpassword1){

                        axios({
                            methods: 'post',
                            url: '/normal/updateUser',
                            params: {
                                phone : this.form.phone,
                                oldPassword : this.form.oldpassword,
                                newPassword : this.form.newpassword1
                            }
                        }).then((request) =>{
                            var datas = request.data;
                            if(datas.status === "1"){
                               this.messageDialog("success","修改密码成功");
                                this.dialogUpdateVisible = false;
                                this.form.phone = '';
                                this.form.oldpassword = '';
                                this.form.newpassword1 = '';
                                this.form.newpassword2 = '';
                            }else{
                                this.messageDialog("info",datas.message);
                            }
                        }).catch(function (error) {
                            this.messageDialog("info","非正常修改失败");
                            })


                    }else{
                        this.messageDialog("info","新密码与确认密码不相同，请确认输入");
                    }
                },
                messageDialog(type,val) {
                    this.$message({
                        type: type,
                        message: val   });
                },
                logout(){
                    window.location.href = "/normal/logout";
                },

            },
            mounted(){
                axios({
                    methods: 'post',
                    url: '/normal/message/getNoSeessMessageSize',
                }).then((request) =>{
                    var datas = request.data;
                    this.messageSize = datas.size;
                    if(this.messageSize == 0){
                        this.messageSize=""
                    }
            })
            }
		})
	</script>
</body>
</html>
