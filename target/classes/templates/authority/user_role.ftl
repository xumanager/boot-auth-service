<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>用户列表</title>
		<link href="/static/css/elementUI.css" rel="stylesheet">
		<script src="/static/js/vue.js"></script>
		<script src="/static/js/index.js"></script>
        <script src="/static/js/vue-axios.js"></script>
	</head>
	<body>
		
		<div id="app">
					<el-container>
							<el-header style="display: flex;align-items: center;height:40px;">
								<el-breadcrumb separator="/" style="font-size: 16px;">
								 <el-breadcrumb-item><a href="../auth/welcome">主页</a></el-breadcrumb-item>
								 <el-breadcrumb-item>用户权限管理</el-breadcrumb-item>
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
								      prop="id"
								      label="序号">
								    </el-table-column>
								    <el-table-column
								      prop="username"
								      label="用户名">
								    </el-table-column>
								    <el-table-column
								      prop="password"
								      label="密码">
								    </el-table-column>
                                     <el-table-column
                                             prop="employee.employeeNo"
                                             label="员工编号">
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
										 prop="remark"
										 label="备注">
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



            <el-dialog title="新增用户" :visible.sync="dialogFormVisible" width="30%">
                <el-form :model="form">
                    <el-form-item label="用户名" style="display: flex;flex-direction: row;justify-content: center">
                        <el-input v-model="form.username" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="密码" style="display: flex;flex-direction: row;justify-content: center">
                        <el-input v-model="form.password" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="员工编号" style="display: flex;flex-direction: row;justify-content: center">
                        <el-input v-model="form.employee.employeeNo" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="备注" style="display: flex;flex-direction: row;justify-content: center">
                        <el-input v-model="form.remark" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="add">确定添加</el-button>
                </div>
            </el-dialog>


            <el-dialog title="修改用户" :visible.sync="dialogUpdateVisible" width="30%">
                <el-form :model="updateForm">
                    <el-form-item label="用户名" style="display: flex;flex-direction: row;justify-content: center">
                        <el-input v-model="updateForm.username" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="密码" style="display: flex;flex-direction: row;justify-content: center">
                        <el-input v-model="updateForm.password" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="员工编号" style="display: flex;flex-direction: row;justify-content: center">
                        <el-input v-model="updateForm.employee.employeeNo" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="备注" style="display: flex;flex-direction: row;justify-content: center">
                        <el-input v-model="updateForm.remark" autocomplete="off" style="width: 200px"></el-input>
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
							list: [],
                            currentPage : 1,
                            pageSize : 5,
                            totalPage : 5,
                            totalSize:4,
                            highSearch : '',
                            dialogFormVisible : false,
                            dialogUpdateVisible : false,
                            form: {
                                username: '',
                                password: '',
                                employee:{
                                    employeeNo : ''
                                },
                                status: '',
                                remark: '',
                            },
                            updateForm: {
                                username: '',
                                password: '',
                                employee:{
                                    employeeNo : ''
                                },
                                status: '',
                                remark: '',
                            },
                            updateFormName : '',
                            empNo:''
						},
                        methods:{
                            getList() {
                                var self = this;
                                axios({
                                    methods: 'post',
                                    url: '/auth/user/getList',
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
                                var string = "此操作将永久删除 "+row.username+" 用户, 是否继续?"
                                this.$confirm(string, '提示', {
                                    confirmButtonText: '确定',
                                    cancelButtonText: '取消',
                                    type: 'warning',
                                    dangerouslyUseHTMLString: true

                                }).then(() => {
                                    var self = this;
                                axios({
                                    methods:'post',
                                    url:'/auth/user/delete',
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
                                if(this.form.username == undefined || this.form.username == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '用户名未输入'});
                                }else if(this.form.password == undefined || this.form.password == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '密码未输入'});
                                }else if(this.form.employee.employeeNo == undefined || this.form.employee.employeeNo == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '员工编号未输入'});
                                }else if(this.form.remark == undefined || this.form.remark == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '备注未输入'});
                                }else{
                                    var self = this;
                                    this.form.status = 0;
                                    axios({
                                        methods:'post',
                                        url:'/auth/user/addAndUpdate',
                                        params :{
                                            user : this.form
                                        }
                                    }).then((request)=>{
                                        console.log(request)
                                        if(request.data.status === '1'){
                                            this.$message({
                                                type: 'success',
                                                message: '添加成功!'
                                            });
                                            this.getList();
                                            this.form.username = "";
                                            this.form.password = "";
                                            this.form.employee.employeeNo = "";
                                            this.form.remark = "";
                                            this.form.status = "";
                                            this.dialogFormVisible = false;
                                        }else{
                                            this.$message({
                                                type: 'info',
                                                message: request.data.message
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
                                this.updateForm.id = row.id;
                                this.updateForm.username = row.username;
                                this.updateForm.password = row.password;
                                this.updateForm.employee.employeeNo = row.employee.employeeNo;
                                this.updateForm.remark = row.remark;
                                this.updateForm.status = row.status;
                                this.updateFormName = row.username;
                                this.empNo = row.employee.employeeNo;
                                this.dialogUpdateVisible = true;
                            },
                            handleUpdate(){
                                if(this.updateForm.username == undefined || this.updateForm.username == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '用户名未输入'});
                                }else if(this.updateForm.password == undefined || this.updateForm.password == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '密码未输入'});
                                }else if(this.updateForm.employee.employeeNo == undefined || this.updateForm.employee.employeeNo == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '员工编号未输入'});
                                }else if(this.updateForm.remark == undefined || this.updateForm.remark == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '备注未输入'});
                                }else{
                                    var self = this;
                                    axios({
                                        methods:'post',
                                        url:'/auth/user/addAndUpdate',
                                        params :{
                                            user : this.updateForm,
                                            updateName : this.updateFormName,
                                            empNo:this.empNo
                                        }
                                    }).then((request)=>{
                                        if(request.data.status === '1'){
                                            this.$message({
                                                type: 'success',
                                                message: '修改成功!'
                                            });
                                            this.getList();
                                            this.dialogUpdateVisible = false;
                                        }else{
                                            this.$message({
                                                type: 'info',
                                                message: request.data.message
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
                                    url:'/auth/user/addAndUpdate',
                                    params :{
                                        user : row,
                                        updateName : row.username
                                    }
                                }).then((request)=>{ })
                            }
                        },
                        mounted() {
                            this.getList();
                        },
					})
				</script>
			</body>
			
		</html>
		