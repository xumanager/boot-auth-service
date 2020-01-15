<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>角色列表</title>
		<link href="/static/css/elementUI.css" rel="stylesheet">
		<script src="/static/js/vue.js"></script>
		<script src="/static/js/index.js"></script>
        <script src="/static/js/vue-axios.js"></script>
        <style>
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
			<el-container>
					<el-header style="display: flex;align-items: center;height:40px;">
						<el-breadcrumb separator="/" style="font-size: 16px;">
						 <el-breadcrumb-item><a href="../auth/welcome">主页</a></el-breadcrumb-item>
						 <el-breadcrumb-item>角色管理</el-breadcrumb-item>
						</el-breadcrumb>
					</el-header>
					
					<el-main >
						<div style="height: 70px;display: flex;flex-direction: row;align-items: center;">
							<el-input v-model="highSearch" placeholder="高级搜索" style="width: 200px;margin-right: 10px;"></el-input>
							<el-button type="primary" icon="el-icon-search" @click="searchFun">搜索</el-button>
							<el-button type="primary" icon="el-icon-plus" @click="dialogFormVisible = true">新增</el-button>
						</div>
						 <el-table
						    :data="list"
						    style="width: 100%">
						    <el-table-column
						      prop="sortnum"
						      label="排序">
						    </el-table-column>
						    <el-table-column
						      prop="rolename"
						      label="角色名">
						    </el-table-column>
						    <el-table-column
						      prop="remark"
						      label="备注">
							  </el-table-column>
							<el-table-column
							  label="可用状态">
                                <template slot-scope="scope">
                                    <el-switch  v-model="scope.row.status"
                                        :active-value="1"
                                        :inactive-value="0"
                                        @change="changeSwitch(scope.row)">
                                </template>
							</el-table-column>
                             <el-table-column
									 label="操作">
                                 <template slot-scope="scope">
									 <el-button  size="mini" type="warning"	  @click="updateUI(scope.row)">修改</el-button>
									 <el-button  size="mini" type="danger" 	 @click="handleDelete(scope.row)">删除</el-button>
								 </template>
                             </el-table-column>
						  </el-table>



						<el-pagination	 background  layout="total,prev, pager, next,jumper"
									   @current-change="currentChangeHandle"
									   :current-page="currentPage"
									   :page-size="pageSize"
									   :total="totalSize" style="display: flex; justify-content: flex-end;margin-top: 10px;">
						</el-pagination> 
					</el-main>
			</el-container>



            <el-dialog title="新增角色" :visible.sync="dialogFormVisible" width="30%">
                <el-form :model="form">
                    <el-form-item label="角色标识" class="myformitem">
                        <el-input v-model="form.rolename" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="排序号" class="myformitem">
                        <el-input v-model="form.sortnum" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="角色" class="myformitem">
                        <el-input v-model="form.remark" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="add">确定添加</el-button>
                </div>
            </el-dialog>


            <el-dialog title="修改角色" :visible.sync="dialogUpdateVisible" width="30%">
                <el-form :model="updateRole">
                    <el-form-item label="角色标识" class="myformitem">
                        <el-input v-model="updateRole.rolename" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="排序号" class="myformitem">
                        <el-input v-model="updateRole.sortnum" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="角色" class="myformitem">
                        <el-input v-model="updateRole.remark" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogUpdateVisible = false">取 消</el-button>
                    <el-button type="warning" @click="handleUpdate">确定修改</el-button>
                </div>
            </el-dialog>


		</div>
		
		<script>
			new Vue({
				el:"#app",
				data:{
                    currentPage : 1,
                    pageSize : 5,
                    totalPage : 5,
					totalSize:4,
                    highSearch : '',
					list:[],
                    dialogFormVisible : false,
                    dialogUpdateVisible : false,
                    form: {
                        rolename: '',
                        remark: '',
                        status: '',
                        sortnum:''
                    },
                    updateRole: {
                        id:'',
                        rolename: '',
                        remark: '',
                        status: '',
                        sortnum:''
                    },
                    updaterolename : ''
				},
				methods:{
                    getList() {
                        var self = this;
                        axios({
                            methods: 'post',
                            url: '/auth/role/getList',
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
                    },
                    currentChangeHandle(val){
                        this.currentPage = val;
                        this.getList();
					},
                    searchFun(){

						this.currentPage = 1;
                        this.getList();
					},
                    handleDelete(row){
                        var string = "此操作将永久删除 "+row.rolename+" 角色, 是否继续?"
                        this.$confirm(string, '提示', {
                            confirmButtonText: '确定',
                            cancelButtonText: '取消',
                            type: 'warning',
                            dangerouslyUseHTMLString: true

                        }).then(() => {
								var self = this;
								axios({
									methods:'post',
									url:'/auth/role/delete',
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
							}).catch(() => {
									this.$message({
									type: 'info',
									message: '已取消删除'
								});
							});
                    	});
					},
					add(){
                        if(this.form.rolename == undefined || this.form.rolename == ""){
                            this.$message({
                                type: 'info',
                                message: '角色名未输入'});
                        }else if(this.form.sortnum == undefined || this.form.sortnum == ""){
                            this.$message({
                                type: 'info',
                                message: '排序号未输入'});
                        }else if(this.form.rolename == undefined || this.form.remark == ""){
                            this.$message({
                                type: 'info',
                                message: '备注未输入'});
                        }else{
							var self = this;
							this.form.status = 0;
							axios({
								methods:'post',
								url:'/auth/role/addAndUpdate',
								params :{
									role : this.form
								}
							}).then((request)=>{
								if(request.data === 'success'){
								this.$message({
									type: 'success',
									message: '添加成功!'
								});
								this.getList();
								this.form.rolename = "";
                                this.form.remark = "";
                                this.form.sortnum = "";
                                this.form.status = "";
                                this.dialogFormVisible = false;
							}else{
								this.$message({
									type: 'info',
									message: '添加失败,角色名已存在！'
								});
							}
							}).catch(function (error) {
								this.$message({
									type: 'info',
									message: '非正常失败！'
								});
							});
						}
                    },
                    updateUI(row){
                        this.updateRole.id = row.id;
                        this.updateRole.rolename = row.rolename;
                        this.updateRole.remark = row.remark;
                        this.updateRole.status = row.status;
                        this.updateRole.sortnum = row.sortnum;
                        this.updaterolename = row.rolename;
                        this.dialogUpdateVisible = true;
					},
					handleUpdate(){
                        if(this.updateRole.rolename == undefined || this.updateRole.rolename == ""){
                            this.$message({
                                type: 'info',
                                message: '角色名未输入'});
                        }else if(this.updateRole.sortnum == undefined || this.updateRole.sortnum == ""){
                            this.$message({
                                type: 'info',
                                message: '排序号未输入'});
                        }else if(this.updateRole.rolename == undefined || this.updateRole.remark == ""){
                            this.$message({
                                type: 'info',
                                message: '备注未输入'});
                        }else{
                            var self = this;
                            axios({
                                methods:'post',
                                url:'/auth/role/addAndUpdate',
                                params :{
                                    role : this.updateRole,
									 rolename : this.updaterolename
                                }
                            }).then((request)=>{
                                if(request.data === 'success'){
                                this.$message({
                                    type: 'success',
                                    message: '修改成功!'
                                });
                                this.getList();
                                this.dialogUpdateVisible = false;
                            }else{
                                this.$message({
                                    type: 'info',
                                    message: '修改失败,角色名已存在！'
                                });
                            }
                        }).catch(function (error) {
                                this.$message({
                                    type: 'info',
                                    message: '非正常修改失败！'
                                });
                            });
                        }
					},
                    changeSwitch(row){
                        console.log(row)
                        var self = this;
                        axios({
                            methods:'post',
                            url:'/auth/role/addAndUpdate',
                            params :{
                                role : row,
                                rolename : row.rolename
                            }
                        }).then((request)=>{});
                    }
				},
                mounted() {
                    this.getList();
                },
			})
		</script>
	</body>
	
</html>
