<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>信息箱</title>
		
		<link href="https://v4.bootcss.com/docs/4.3/dist/css/bootstrap.css" rel="stylesheet">
		<link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
		<script src="/static/js/vue.js"></script>
		<script src="/static/js/index.js"></script>
        <script src="/static/js/vue-axios.js"></script>
		<style>
			#app{
				padding: 20px 60px;
			}
			.myformitem{
			            display: flex;
			            flex-direction: row;
			            justify-content: flex-start;
			        }
			        .myformitem label{
			            width: 100px;
			        }
		</style>
	</head>
	<body>
		<div id="app">
			<el-dialog title="发送信息" :visible.sync="dialogUpdateVisible" width="40%">
				<el-form :model="form">
					<el-form-item label="收件人" class="myformitem">
						<el-input v-model="form.receiver" placeholder="收件人用户名 , 多人则用英文逗号隔开" autocomplete="off" style="width: 400px"></el-input>
					</el-form-item>
					<el-form-item label="主题" class="myformitem">
						<el-input v-model="form.theme" autocomplete="off" style="width: 400px"></el-input>
					</el-form-item>
					<el-form-item label="内容" class="myformitem">
						<el-input type="textarea" v-model="form.content" autocomplete="off" style="width: 400px;" :autosize="{ minRows: 2, maxRows: 4}"></el-input>
					</el-form-item>
				</el-form>
				<div slot="footer" class="dialog-footer">
					<el-button @click="dialogUpdateVisible = false">取 消</el-button>
					<el-button type="warning" @click="sendMessage">发 送</el-button>
				</div>
			</el-dialog>
			<el-container>
			  <el-header style="height:80px;">
				<h6 style="color: #808080;font-weight: 800;">收件箱<span style="font-weight: 300;font-size:14px;">（共 {{this.list.length}} 封）</span></h6>
				<div style="margin-top: 25px;display: flex;flex-direction: row;">
					<el-button size="mini" @click="dialogUpdateVisible = true">新建信息发送</el-button>
					<el-button size="mini" @click="deleteAll">全部删除</el-button>
					<el-button size="mini" @click="biaojiAll">全部标记已读</el-button>
                    <el-input v-model="highSearch" placeholder="高级搜索" style="margin-left:10px;width:300px;"  >
                        <el-button slot="append" icon="el-icon-search" stlye="background-color:#fff;" @click="searchFun"></el-button>
                    </el-input>
					<div style="display: flex;flex-direction: row-reverse;flex-grow: 1;">
						<el-pagination
                                layout="prev, pager, next,jumper"
							@current-change="currentChangeHandle"
							:current-page="currentPage"
							:page-size="pageSize"
                            :total="totalSize"
                            style="align-self:flex-end;">
						</el-pagination>
					</div>
					
				</div>
			  </el-header>
			  <el-main>
				   <el-table
				        :data="list"
				        style="width: 100%">
				        <el-table-column
				          width="80">
						  <template slot-scope="scope">
							   <i class="el-icon-postcard" v-if="scope.row.status==1" style="color: cornflowerblue;font-weight: 800;"   @click="toNoSee(scope.row)"></i>
							   <i class="el-icon-message" v-if="scope.row.status==0"   @click="toNoSee(scope.row)"></i>
						  </template>
					
				        </el-table-column>
				        <el-table-column
				          prop="sender"
				          label="发件人"
						  width="200">
				        </el-table-column>
						<el-table-column
						  prop="theme"
						  label="主题">
						</el-table-column>
						<el-table-column
						  prop="date"
						  label="时间"
						  width="200">
						</el-table-column>
						<el-table-column
						  label="操作"
						  width="200">
                            <template slot-scope="scope">
								  <a href="#" style="font-size:18px;margin-right:15px ;"><i class="el-icon-view" style="color: #808080;" @click="open(scope.row)"></i></a>
									<a href="#" style="font-size:18px;margin-right:15px ;"><i class="el-icon-share" style="color: #808080;" @click="shareToOtherUser(scope.row)"></i></a>
									<a href="#" style="font-size:18px;margin-right:15px ;"><i class="el-icon-s-promotion" style="color: #808080;" @click="shareToIt(scope.row)"></i></a>
								   <a href="#" style="font-size:18px;"><i class="el-icon-delete" style="color: #808080;"  @click="handleDelete(scope.row)"></i></a>
                            </template>
						</el-table-column>
				      </el-table>
				  
			  </el-main>
			</el-container>
		</div>
		
		<script>
			new Vue({
				el:"#app",
				data:{
				   form:{
					   receiver:'',
					   theme:'',
					   content:'',
					   sender:'',
					   date:'',
					   status:''
				   },
				   dialogUpdateVisible :false,
					currentPage : 1,
					pageSize : 8,
					totalPage : 5,
					totalSize:4,
					highSearch : '',
                    list:[],
				},
				methods:{
					deleteAll(){
						 this.$confirm('是否删除所有信息？', '提示', {
							confirmButtonText: '确定',
							cancelButtonText: '取消',
							type: 'warning',

						}).then(() => {
                             var self = this;
                        axios({
                            methods: 'post',
                            url: '/normal/message/deleteAllMessage',
                        }).then((request) =>{
                            this.$message({
                            type: 'success',
                            message: '删除成功 '});
                        this.getList();
                    })
						})
					},
					biaojiAll(){
						this.$confirm('是否标记所有信息已读？', '提示', {
							confirmButtonText: '确定',
							cancelButtonText: '取消',
							type: 'warning',
						}).then(() => {
							var self = this;
							axios({
								methods: 'post',
								url: '/normal/message/makeAllMessageIsSee',
							}).then((request) =>{
								this.$message({
									type: 'success',
									message: '标记成功 '});
								this.getList();
							})
						})
					},
                    searchFun(){
                        this.currentPage = 1;
                        this.getList();
                    },
					toNoSee(row){
					    if(row.status == 1){
                            var self = this;
                            axios({
                                methods: 'post',
                                url: '/normal/message/makeMessageNoSee',
                                params:{
                                    id:row.id
                                }
                            }).then((request) => {
                                this.$message({
                                type: 'success',
                                message: '已标记为未读信息 ' });
                            this.getList();
                        })
						}

					},
                    shareToOtherUser(row){
                        this.$prompt('请输入用户名,多人用英文逗号隔开', '转发', {
                            confirmButtonText: '转发',
                            cancelButtonText: '取消',
                        }).then(({ value }) => {
                            var str = value.toString().replace(/^ +| +$/g,'');
                           axios({
                                methods: 'post',
                                url: '/normal/message/sendMessage',
                                params:{
                                    users : str,
                                    theme : "转发自"+row.sender+"："+row.theme,
                                    content : row.content
                                }
                            }).then((request) => {
                                this.$message({
                                type: 'success',
                                message: '转发成功 ' });
                            this.getList();
                        })




                    })
                    },
                    shareToIt(row){
                        this.$prompt('请输入信息', '回复', {
                            confirmButtonText: '回复',
                            cancelButtonText: '取消',
                        }).then(({ value }) => {
							//value
                            axios({
								  methods: 'post',
								  url: '/normal/message/reply',
								  params:{
										message:{
											id : null,
											receiver : row.sender,
											sender : row.receiver,
											theme : "回复："+row.theme,
											date : null,
											content : value,
											status : 0
										}
								  }
							  }).then((request) => {
                            this.$message({
                            type: 'success',
                            message: '回复成功 ' });
                        this.getList();
                  			  })
                   		 })
                    },
                    currentChangeHandle(val){
                        this.currentPage = val;
                        this.getList();
                    },
                    sendMessage(){
                        if(this.form.receiver == undefined || this.form.receiver == "" || this.form.receiver.indexOf(" ") >=0 ){
                            this.$message({
                                type: 'info',
                                message: '收件人未输入或者已输入空格'});
                        }else if(this.form.theme == undefined || this.form.theme == ""){
                            this.$message({
                                type: 'info',
                                message: '主题未输入'});
                        }else if(this.form.content == undefined || this.form.content == ""){
                            this.$message({
                                type: 'info',
                                message: '内容未输入'});
                        }else{
                            var self = this;
                            var userList = this.form.receiver.split(',');
                            axios({
                                methods: 'post',
                                url: '/normal/message/sendMessage',
                                params:{
                                    users : this.form.receiver,
									theme : this.form.theme,
									content : this.form.content
                                }
                            }).then((request) => {
                                this.$message({
                                type: 'success',
                                message: '发送成功'});
								this.dialogUpdateVisible = false;
								this.getList();
                        })

                        }
                    },
                    open(row){
					    var string = "<p>来自："+row.sender+"</p><p>主题："+row.theme+"</p><p>内容："+row.content+"</p>";
                        this.$alert(string, '消息', {
                            dangerouslyUseHTMLString: true
                        });
                        var self = this;
                        axios({
                            methods: 'post',
                            url: '/normal/message/makeMessageIsSee',
                            params:{
                                id:row.id
                            }
                        }).then((request) => {
                        this.getList();
                    })
					},
                    handleDelete(row){
                        var string = "此操作将永久删除该消息且无法撤回, 是否继续?"
                        this.$confirm(string, '提示', {
                            confirmButtonText: '确定',
                            cancelButtonText: '取消',
                            type: 'warning',
                            dangerouslyUseHTMLString: true

                        }).then(() => {
                            var self = this;
                        axios({
                            methods:'post',
                            url: '/normal/message/delete',
                            params :{
                                id : row.id
                            }
                        }).then((request)=>{
                            if(request.data === 'success'){
                            this.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            this.getList();
                        }else{
                            this.$message({
                                type: 'info',
                                message: '删除失败'
                            });
                        }
                    }).catch(function (error) {
                            this.$message({
                                type: 'info',
                                message: '非正常删除失败！'});
                        })
                    });
                    },

                    getList(){
                        var self = this;
                        axios({
                            methods: 'post',
                            url: '/normal/message/getMessageList',
                            params: {
                                currentPage: this.currentPage,
                                pageSize: this.pageSize,
                                highSearch: this.highSearch
                            }
                        }).then((request) =>{
                            var datas = request.data;
							self.totalPage = datas.totalPages;
							self.totalSize = datas.totalElements;
							self.list = datas.content;
						}).catch(function (error) {
								alert("获取数据失败");
							})
					}
				},
                mounted() {
				    this.getList();

				},
			})
		</script>
	</body>
</html>
