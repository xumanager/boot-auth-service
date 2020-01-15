<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>用户列表</title>
		<link href="/static/css/elementUI.css" rel="stylesheet">
		<script src="/static/js/vue.js"></script>
		<script src="/static/js/index.js"></script>
        <script src="/static/js/vue-axios.js"></script>
        <script src="/static/js/jquery-1.11.0.js"></script>
	</head>
    <style>
        .box {
            width: 400px;
            .right {
                float: right;
                width: 60px;
            }
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
	<body>
		
		<div id="app">
					<el-container>
							<el-header style="display: flex;align-items: center;height:40px;">
								<el-breadcrumb separator="/" style="font-size: 16px;">
								 <el-breadcrumb-item><a href="../auth/welcome">主页</a></el-breadcrumb-item>
								 <el-breadcrumb-item>用户管理</el-breadcrumb-item>
								</el-breadcrumb>
							</el-header>
                            <el-dialog title="发送信息" :visible.sync="dialogSendMessage" width="50%">
                                <el-form :model="messageForm">
                                    <el-form-item label="收件人" class="myformitem">
                                        <el-select
                                                v-model="messageForm.users"
                                                multiple
                                                collapse-tags
                                                style="margin-left: 20px;"
                                                placeholder="请选择">
                                            <el-option
                                                    v-for="item in allList"
                                                    :key="item.username"
                                                    :label="item.show"
                                                    :value="item.username">
                                            </el-option>
                                        </el-select>
                                    </el-form-item>
                                    <el-form-item label="主题" class="myformitem">
                                        <el-input v-model="messageForm.theme" autocomplete="off" style="width: 400px"></el-input>
                                    </el-form-item>
                                    <el-form-item label="内容" class="myformitem">
                                        <el-input type="textarea" v-model="messageForm.content" autocomplete="off" style="width: 400px;" :autosize="{ minRows: 2, maxRows: 4}"></el-input>
                                    </el-form-item>
                                </el-form>
                                <div slot="footer" class="dialog-footer">
                                    <el-button @click="dialogSendMessage = false">取 消</el-button>
                                    <el-button type="warning" @click="sendMessage">发 送</el-button>
                                </div>
                            </el-dialog>
							<el-main >
                                <div style="height: 70px;display: flex;flex-direction: row;align-items: center;">
                                    <el-input v-model="highSearch" placeholder="高级搜索" style="width: 200px;margin-right: 10px;"></el-input>
                                    <el-button type="primary" icon="el-icon-search" @click="searchFun">搜索</el-button>
                                    <el-button type="primary" icon="el-icon-plus" @click="addUI">新增</el-button>
                                    <el-button type="primary" icon="el-icon-message" @click="openSend">群发消息</el-button>
                                </div>
								 <el-table
								    :data="list"
								    style="width: 100%">
								    <el-table-column
								      prop="id"
								      label="序号"
                                    width="80">
								    </el-table-column>
								    <el-table-column
								      prop="username"
								      label="用户名">
                                        <template slot-scope="scope">
                                            <el-tooltip class="item" placement="right">
                                                <div slot="content">密码：{{scope.row.password}}</div>
                                                <el-button style="border: 0;padding: 0;margin: 0;">{{scope.row.username}}</el-button>
                                            </el-tooltip>
                                        </template>
								    </el-table-column>
                                     <el-table-column
                                             prop="employee.employeeNo"
                                             label="所属员工">
                                         <template slot-scope="scope">
                                             <div v-if="scope.row.employee!=null">
                                                 <el-tooltip class="item" placement="right">
                                                         <div slot="content">{{scope.row.employee.employeeNo}}</div>
                                                         <el-button style="border: 0;padding: 0;margin: 0;">{{scope.row.employee.employeeName}}</el-button>

                                                 </el-tooltip>
                                             </div>
                                         </template>
                                     </el-table-column>

                                     <el-table-column
                                             prop="phone"
                                             label="手机号码">
                                     </el-table-column>
                                     <el-table-column
                                             prop="email"
                                             label="邮箱地址"
                                             width="200">
                                     </el-table-column>
                                     <el-table-column
										 prop="employee.job"
										 label="员工职位">
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
                                             label="操作"
                                     width="300">
                                         <template slot-scope="scope">
                                             <el-button  size="mini" type="success"	  @click="assignRole(scope.row)">角色</el-button>
                                             <el-button  size="mini" type="warning"	  @click="updateUI(scope.row)">修改</el-button>
                                             <el-button  size="mini" type="danger" 	 @click="handleDelete(scope.row)">删除</el-button>
                                             <el-dialog title="分配角色" :visible.sync="dialogTableVisible">
                                                 <el-table :data="allRole">
                                                     <el-table-column property="sortnum" label="排序"> </el-table-column>
                                                     <el-table-column property="rolename" label="角色名"> </el-table-column>
                                                     <el-table-column property="remark" label="备注"></el-table-column>
                                                     <el-table-column  label="操作">
                                                         <template slot-scope="scopee">
                                                             <el-button  size="mini" type="danger" v-if="scopee.row.have==1" @click="repealAndGive(scopee.row.id,'0')">撤销</el-button>
                                                             <el-button  size="mini" type="primary" v-if="scopee.row.have==0" @click="repealAndGive(scopee.row.id,'1')">授予</el-button>
                                                         </template>
                                                     </el-table-column>
                                                 </el-table>
                                             </el-dialog>

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
                    <el-form-item label="用户名" class="myformitem">
                        <el-input v-model="form.username" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="密码" class="myformitem">
                        <el-input v-model="form.password" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    </el-form-item>
                    <el-form-item label="所属员工" class="myformitem">
                        <el-select v-model="form.employee.employeeNo" placeholder="请选择">
                            <el-option
                                    v-for="emp in empList"
                                    :key="emp.employeeNo"
                                    :label="emp.employeeName"
                                    :value="emp.employeeNo"
                                    :disabled="emp.disabled">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="手机号码" class="myformitem">
                        <el-input v-model="form.phone" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="邮箱地址" class="myformitem">
                        <el-input v-model="form.email" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="add">确定添加</el-button>
                </div>
            </el-dialog>


            <el-dialog title="修改用户" :visible.sync="dialogUpdateVisible" width="30%">
                <el-form :model="updateForm">
                    <el-form-item label="用户名" class="myformitem">
                        <el-input v-model="updateForm.username" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="密码" class="myformitem">
                        <el-input v-model="updateForm.password" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="所属员工" class="myformitem">
                        <el-select v-model="updateForm.employee.employeeNo" placeholder="请选择">
                            <el-option
                                    v-for="emp in empList"
                                    :key="emp.employeeNo"
                                    :label="emp.employeeName"
                                    :value="emp.employeeNo"
                                    :disabled="emp.disabled">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="手机号码" class="myformitem">
                        <el-input v-model="updateForm.phone" autocomplete="off" style="width: 200px"></el-input>
                    </el-form-item>
                    <el-form-item label="邮箱地址" class="myformitem">
                        <el-input v-model="updateForm.email" autocomplete="off" style="width: 200px"></el-input>
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
                            empList:[],
                            allList:[],
                            noEmployeeList : [],
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
                                phone:'',
                                email:''
                            },
                            updateForm: {
                                username: '',
                                password: '',
                                employee:{
                                    employeeNo : ''
                                },
                                status: '',
                                phone:'',
                                email:'',
                                roleSet:'',

                            },
                            messageForm:{
							    users : [],
                               theme:'',
                               content:''
                            },
                            updateFormName : '',
                            empNo:'',
                            dialogTableVisible : false,
                            dialogSendMessage : false,
                            allRole:'',
                            willRoleUserId:''

						},
                        methods:{
						    openSend(){
						        this.messageForm = {
                                    users : [],
                                    theme:'',
                                    content:''
                                };
                                axios({
                                    methods: 'post',
                                    url: '/auth/user/getAll',
                                }).then((request) => {
                                    this.allList = request.data;

                                    for(var i=0;i<this.allList.length;i++){
                                        if(this.allList[i].employee != null){
                                            this.allList[i]['show'] = this.allList[i].username + "---"+this.allList[i].employee.employeeName;;
                                        }else{
                                            this.allList[i]['show'] = this.allList[i].username
                                        }
                                    }
                                    this.dialogSendMessage = true;
                                })
                            },
                            sendMessage(){

                                if(this.messageForm.length < 0){
                                    this.$message({
                                        type: 'info',
                                        message: '未选中收件人'});
                                }else if(this.messageForm.theme == undefined || this.messageForm.theme == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '主题未输入'});
                                }else if(this.messageForm.content == undefined || this.messageForm.content == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '内容未输入'});
                                }else{
                                    var self = this;

                                    var str = "";
                                    console.log(this.messageForm.users);
                                    for(var i = 0 ;i<this.messageForm.users.length;i++){
                                        if(i == this.messageForm.users.length - 1){
                                            str = str +this.messageForm.users[i];
                                            break;
                                        }
                                        str = str + this.messageForm.users[i]+",";
                                    }
                                    console.log(str)
                                    axios({
                                        methods: 'post',
                                        url: '/normal/message/sendMessage',
                                        params:{
                                            users : str.toString(),
                                            theme : this.messageForm.theme,
                                            content : this.messageForm.content
                                        }
                                    }).then((request) => {
                                        this.$message({
                                        type: 'success',
                                        message: '群发成功'});
                                    this.dialogSendMessage = false;
                                })

                                }
                            },
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
                                    console.log(datas)
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
                            getAllEmployee(){
                                var self = this;
                                axios({
                                    methods: 'post',
                                    url: '/company/emp/getNoEmployee',
                                }).then((request) =>{
                                    console.log("");
                                  this.noEmployeeList = request.data;
                                  })
                                axios({
                                    methods: 'post',
                                    url: '/company/emp/getAllEmployee',
                                }).then((request) =>{
                                    console.log("");

                                this.empList = request.data;
                                for(var i=0;i<this.empList.length;i++){
                                    this.empList[i].employeeName = this.empList[i].employeeNo + " "+this.empList[i].employeeName;
                                }
                                //将不可选的标记上
                                // disabled: true
                                for(var i=0;i<this.noEmployeeList.length;i++){
                                    for(var k=0;k<this.empList.length;k++){
                                        if(this.empList[k].employeeNo == this.noEmployeeList[i].employeeNo){
                                            this.empList[k]['disabled'] = true;
                                        }
                                    }
                                }
                            }).catch(function (error) {
                                })
                            },
                            addUI(){
                                this.getAllEmployee();
                                this.dialogFormVisible = true;
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
                                        message: '所属员工未选择'});
                                }else if(this.form.phone == undefined || this.form.phone == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '手机号码未输入'});
                                }else if(this.form.email == undefined || this.form.email == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '邮箱地址未输入'});
                                }else{
                                    var self = this;
                                    this.form.status = 1;
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
                                            this.form.status = "";
                                            this.form.phone = "";
                                            this.form.email = "";
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
                                if(row.employee==null){
                                    this.updateForm.employee.employeeNo = "";
                                }else{
                                    this.updateForm.employee.employeeNo = row.employee.employeeNo;
                                }
                                this.updateForm.roleSet = row.roleSet;
                                this.updateForm.status = row.status;
                                this.updateForm.phone = row.phone;
                                this.updateForm.email = row.email;
                                this.updateFormName = row.username;


                                this.getAllEmployee();
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
                                }else if(this.updateForm.phone == undefined || this.updateForm.phone == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '手机号码未输入'});
                                }else if(this.updateForm.email == undefined || this.updateForm.email == ""){
                                    this.$message({
                                        type: 'info',
                                        message: '邮箱地址未输入'});
                                }else{
                                    var self = this;
                                    axios({
                                        methods:'post',
                                        url:'/auth/user/addAndUpdate',
                                        params :{
                                            user : this.updateForm,
                                            updateName : this.updateFormName
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
                            },
                            assignRole(row){
                                this.getList();
                                var self = this;
                                this.willRoleUserId = row.id;
                                axios({
                                    methods:'post',
                                    url:'/auth/role/getAllRole',
                                }).then((request)=> {
                                    console.log("");
                                    this.allRole = request.data;
                                    for(var i = 0;i < this.allRole.length;i++) {
                                        this.allRole[i]['have'] = 0;
                                    }
                                   for(var i = 0;i < this.allRole.length;i++) {
                                       for (var k = 0; k < row.roleSet.length; k++) {
                                           if (row.roleSet[k].rolename === this.allRole[i].rolename) {
                                               this.allRole[i]['have'] = 1;
                                               break;
                                           }
                                       }
                                   }
                                   this.dialogTableVisible = true;

                                })
                            },
                            repealAndGive(rid,num){
                                var url;
                                if(num === "1"){
                                    url = '/auth/user/giveRole';

                                }else{
                                    //撤销角色
                                    url = '/auth/user/repealRole';

                                }
                                axios({
                                    methods:'post',
                                    url:url,
                                    params:{
                                        uid : this.willRoleUserId,
                                        rid : rid
                                    }
                                }).then((request)=>{

                                })
                                this.dialogTableVisible = false;
                                this.getList();
                                if(num === "1"){

                                    this.$message({
                                        type: 'success',
                                        message: '授予角色成功'});
                                }else{
                                    //撤销角色

                                    this.$message({
                                        type: 'info',
                                        message: '撤销角色成功'});
                                }
                            }
                        },
                        mounted() {
                            this.getList();
                        },

					})
				</script>
			</body>
			
		</html>
		