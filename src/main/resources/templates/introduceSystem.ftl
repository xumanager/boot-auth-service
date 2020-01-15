<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>系统介绍</title>
        <link href="https://v4.bootcss.com/docs/4.3/dist/css/bootstrap.css" rel="stylesheet">
		<link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
		<script src="/static/js/vue.js"></script>
		<script src="/static/js/index.js"></script>
		<style>
			*{
				margin: 0;
				padding: 0;
			}
			.tip {
			    padding: 8px 16px;
			    background-color: #ecf8ff;
			    border-radius: 4px;
			    border-left: 5px solid #50bfff;
			    margin: 20px 0;
			}
			.hui{
				padding: 20px 25px;
				background-color: #eee;
				color: #808080;
				margin: 20px 0;
				font-size: 13px;
			}
			#app{
				margin: 0 auto;
				width: 80%;
			}
			p{
				color: #808080;
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
			.mybox-leave-active,.mybox-enter-active{
			   transition: all 1s ease; 
			  }
			  .mybox-leave-active,.mybox-enter{
			   opacity:0 !important;
			  }
			  .mybox-leave,.mybox-enter-active{
			   opacity: 1;
			  }
		</style>
	</head>
	<body>
		
		<div id="app">
			<el-container>
				<el-header></el-header>
			  <el-main>
				  <div>
					  <h4 style="font-weight: 500;">系统介绍</h4>
                      <div class="tip">
                          <br>
                          <p>系统统一管理所有的用户、角色以及资源。</p>
                          <br>
                          <p>当不同系统用户登录系统时，系统会根据用户所具有的的权限角色分配不同的可访问资源，限制用户对系统的操作。</p>
                          <br>
                          <p>系统用户之间还可以通过系统进行简单的信息传递。</p>
                          <br>
                      </div>
					  <br>
                      <h4 style="font-weight: 500;">模块介绍</h4>
                      <br><br>
					  <p>
							系统管理
					  </p>
					  <div class="hui">
					  		系统中所注册的用户，所定义的角色，所拥有的的资源统一管理在这一模块。
					  </div>
					  <br>
					  <p>
							用户身份认证
					  </p>
					  <div class="hui">
							系统中的用户登录系统，会分配对应的角色进行访问系统，未登录验证的访问者无权限访问系统。
					  </div>
					  <br>
					  <p>
						  权限管理
					  </p>
					  <div class="hui">
						  一般指根据系统设置的安全规则或者安全策略，用户可以访问而且只能访问自己被授权的资源。
					  </div>
					  <br>
                      <p>
                          系统内消息交流
                      </p>
                      <div class="hui">
                          用户之间可以通过系统邮件发送进行交流。
                      </div>
					  <br><br><br>


					  <h4 style="font-weight: 500;">实现技术及页面展示</h4>
					  <br><br>
					  <p>
							本系统采用JavaWeb技术实现，分前后端不同的技术，非前后端分离系统。下面主要介绍一下采用的前后端技术有哪些以及采用的开发和管理工具。
					  </p>
					  <br><br>
					  <el-row>
					    <el-button type="warning" @click="showQian = !showQian">前端技术</el-button>
					    <el-button type="primary" @click="showHou = !showHou">后端技术</el-button>
					    <el-button type="info" @click="showOther = !showOther">Anything</el-button>
						<el-button type="success" @click="showYe = !showYe">页面展示</el-button>
					    <el-button type="danger" @click="close">关闭所有</el-button>
					  </el-row>
					  	<br><br><br>
					   <transition name="mybox">
						
						  <el-carousel :interval="4000" type="card" v-if="showQian">
								<el-page-header @back="showQian=false"  content="前端技术"  style="color:cornflowerblue;"></el-page-header>
							  <el-carousel-item v-for="item in qianduan" :key="item" >
								<div class="div" :style="{'background': 'url('+item.url+') ','background-size':' 100% 100%'}"  >
									<h3 class="medium">{{ item.name }}</h3>
								</div>
							  </el-carousel-item>
						  </el-carousel>
					  </transition>
					  <br><br><br>
					  
					     <transition name="mybox">
					  <el-carousel :interval="4000" type="card" v-if="showHou" >
						  <el-page-header @back="showHou=false"  content="后端技术"  style="color:cornflowerblue;"></el-page-header> 
					      <el-carousel-item v-for="item in houduan" :key="item" >
					  		<div class="div" :style="{'background': 'url('+item.url+') ','background-size':' 100% 100%'}"  >
					  			<h3 class="medium">{{ item.name }}</h3>
					  		</div>
					      </el-carousel-item>
					  </el-carousel>
					  </transition>
					  <br><br><br>
					  
					     <transition name="mybox">
					  <el-carousel :interval="4000" type="card" v-if="showOther">
						   <el-page-header @back="showOther=false"  content="其他"  style="color:cornflowerblue;"></el-page-header> 
					      <el-carousel-item v-for="item in anything" :key="item" >
					  		<div class="div" :style="{'background': 'url('+item.url+') ','background-size':' 100% 100%'}"  >
					  			<h3 class="medium">{{ item.name }}</h3>
					  		</div>
					      </el-carousel-item>
					  </el-carousel>
					   </transition>
					   
					   
					   
					   <br><br><br>
					   
					      <transition name="mybox" >
							  
							  <div v-if="showYe">
								  	 <el-page-header @back="showYe=false"  content="系统页面"  style="color:cornflowerblue;"></el-page-header> 
								<br><br>
								<h4>登录注册页面</h4>
								<el-carousel :interval="4000" type="card">
								      <el-carousel-item v-for="item in ye_index" :key="item" >
								  		<div class="div" :style="{'background': 'url('+item.url+') ','background-size':' 100% 100%'}"  >
								  		</div>
								      </el-carousel-item>
								  </el-carousel>
								  <br><br>
								  <h4>权限管理页面</h4>
								  <el-carousel :interval="4000" type="card">
								        <el-carousel-item v-for="item in ye_auth" :key="item" >
								    		<div class="div" :style="{'background': 'url('+item.url+') ','background-size':' 100% 100%'}"  >
								    		</div>
								        </el-carousel-item>
								    </el-carousel>
                                  <br><br>
                                  <h4>信息交流页面</h4>
                                  <el-carousel :interval="4000" type="card">
                                      <el-carousel-item v-for="item in info" :key="item" >
                                          <div class="div" :style="{'background': 'url('+item.url+') ','background-size':' 100% 100%'}"  >
                                          </div>
                                      </el-carousel-item>
                                  </el-carousel>
							  </div>
					    </transition>
				  </div>
				  
				  
				  
			  </el-main>
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
				</footer>
			</el-container>
			
			
		</div>
		
		<script>
			new Vue({
				el:"#app",
				data:{
					showQian : false,
					showHou : false,
					showOther : false,
					showYe : false,
					qianduan:[
						{
							name:'HTML、css、js',
						},
						{
							name:'JQuery',
							url:'/static/image/introduce/jquery.png',
						},
						{
							name:'Vue',
							url:'/static/image/introduce/vue.png',
						},
						{
							name:'Boostrap',
							url:'/static/image/introduce/boostrap.png',
						},
						{
							name:'ElementUI',
							url:'/static/image/introduce/element.png',
						},
					],
					houduan:[
						{
							name:'Java',
						},
						{
							name:'SpringBoot',
							url:'/static/image/introduce/springboot.png',
						},
						{
							name:'SpringDataJpa',
							url:'/static/image/introduce/springdatajpa.png',
						},
						{
							name:'Shiro',
							url:'/static/image/introduce/shiro.png',
						},
					],
					anything:[
						{
							name:'Mysql',
							url:'/static/image/introduce/mysql.png',
						},
						{
							name:'IntelliJ IDEA',
							url:'/static/image/introduce/idea.png',
						},
						{
							name:'Tomcat',
							url:'/static/image/introduce/tomcat.png',
						},
						{
							name:'Maven',
							url:'/static/image/introduce/maven.png',
						},
					],
					ye_index:[
						{
							url:'/static/image/introduce/index_noLogin.png',
						},
						{
							url:'/static/image/introduce/login.png',
						},
						{
							url:'/static/image/introduce/regist.png',
						},
						{
							url:'/static/image/introduce/index_pu.png',
						},
						{
							url:'/static/image/introduce/index_account.png',
						},
						{
							url:'/static/image/introduce/login_admin.png',
						},
					],
					ye_auth:[
						{
							url:'/static/image/introduce/auth_index.png',
						},
						{
							url:'/static/image/introduce/auth_user.png',
						},
						{
							url:'/static/image/introduce/auth_role.png',
						},
						{
							url:'/static/image/introduce/auth_resouce.png',
						},
						{
							url:'/static/image/introduce/add.png',
						},
						{
							url:'/static/image/introduce/update.png',
						},
						{
							url:'/static/image/introduce/delete.png',
						},
						{
							url:'/static/image/introduce/assign.png',
						},
					],
                    info:[
                        {
                            url:'/static/image/introduce/info.png',
                        },
					]

				},
				methods:{
					close(){
						this.showHou = false;
						this.showOther = false;
						this.showQian = false;
						this.showYe = false;
					}
				}
			})
		</script>
	</body>
</html>
