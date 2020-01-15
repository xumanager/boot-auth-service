<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>公司管理页面</title>
		<link href="/static/css/elementUI.css" rel="stylesheet">
		<script src="/static/js/vue.js"></script>
		<script src="/static/js/index.js"></script>
		
		<style type="text/css">
			html,body{
				width: 100%;
				height: 100%;
			}
			body{
				overflow: hidden;
				display: flex;
                background-color: rgb(84, 92, 100);
			}
			#app{
				display: flex;
				flex-grow: 1;
			}
			#mainshow{
				width: 100%;
			}
			li:focus > a{
				color: #409EFF;
				text-decoration: none;
			}
			a {
				color: #303133;
			    text-decoration: none;
				    transition: border-color .3s,background-color .3s,color .3s;
			}
			a:link {
				color: #303133;
			    text-decoration: none;
			}
			a:visited {
				color: #303133;
			    text-decoration: none;
			}
			a:hover {
				color: #303133;
			    text-decoration: none;
			}
			a:active {
				 color: #409EFF;
			    text-decoration: none;
				
			}
			a:focus {
				 color: #409EFF;
			    text-decoration: none;
				    transition: border-color .3s,background-color .3s,color .3s;
			}
		</style>
	</head>
	<body>
		<div id="app">
			<el-container id="secc">
				<el-aside width="200px">
					<el-row class="tac">
					  <el-col :span="24">
						 <h3  style="text-align: center;color:#fff;">公司资源管理</h3>
						<el-menu

                                background-color="#545c64"
                                text-color="#fff"
                                active-text-color="#ffd04b"
						 default-active="1"
						  class="el-menu-vertical-demo">
						  <el-submenu index="1">
							<template slot="title">
							  <i class="el-icon-menu"></i>
							  <span>资源管理</span>
							</template>
							<el-menu-item index="1-1" @click="page('/company/emp/empList')">员工管理</el-menu-item>
							  <el-menu-item index="1-2" >部门管理</el-menu-item>
                              <el-menu-item index="1-3" >岗位管理</el-menu-item>
						  </el-submenu>
						   
						  <el-submenu index="2">
							<template slot="title">
							  <i class="el-icon-document"></i>
							  <span>消息管理</span>
							</template>
							<el-menu-item-group>
							  <el-menu-item index="2-1"  @click="page('../auth/apply')">登录日志</el-menu-item>
							   <el-menu-item index="2-2"  @click="page('../auth/update')">通知公告</el-menu-item>
							  <el-menu-item index="2-3"  @click="page('../auth/list')">操作日志</el-menu-item>
							</el-menu-item-group>
						  </el-submenu>
						</el-menu>
					  </el-col>
					</el-row>
				</el-aside>
				<el-container>
					<div id="mainshow">
						<iframe id="iframe" style="margin: 0px;padding: 0px;" src="" name="iframe" align="center" scrolling="yes" width="100%" height="100%" frameborder="no" ></iframe>
					</div>
				</el-container>
			</el-container>
		</div>
		
	</body>
	  <script>
		
		  
		new Vue({
		  el: '#app',
		  data:{
			  url:'213',
				authoList:[
					{
						name:'许成思',
						username:'xuchengsi',
						password:'1234',
						job:'管理员',
						auths:[]
					},
					{
						name:'许成思',
						username:'xuchengsi',
						password:'1234',
						job:'管理员',
						auths:[]
					},
					{
						name:'许成思',
						username:'xuchengsi',
						password:'1234',
						job:'管理员',
						auths:[]
					},
					{
						name:'许成思',
						username:'xuchengsi',
						password:'1234',
						job:'管理员',
						auths:[]
					},
					{
						name:'许成思',
						username:'xuchengsi',
						password:'1234',
						job:'管理员',
						auths:[]
					},
					{
						name:'许成思',
						username:'xuchengsi',
						password:'1234',
						job:'管理员',
						auths:[]
					},
					{
						name:'许成思',
						username:'xuchengsi',
						password:'1234',
						job:'管理员',
						auths:[]
					},
					{
						name:'许成思',
						username:'xuchengsi',
						password:'1234',
						job:'管理员',
						auths:[]
					},
				]
		  },
		  methods:{
			  page(url){
				  document.getElementById("iframe").src=url;
			  }
		  },
		
		})
	  </script>
</html>