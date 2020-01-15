<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>资源列表</title>
    <link href="/static/css/elementUI.css" rel="stylesheet">
    <script src="/static/js/vue.js"></script>
    <script src="/static/js/index.js"></script>
    <script src="/static/js/vue-axios.js"></script>
</head>
<style>
    body{

    }
    .el-table tr{
        background: rgb(84, 92, 100);

    }
    tbody tr{

        color:#fff;
    }
    .el-pagination__total{
        color:#fff;
    }
    .el-pagination__jump{
          color:#fff;
      }
    #spanY span{
        color:#fff;
    }
    #button{
        background-color: #67b168;border:#67b168 solid 1px;
    }
    #button:hover{
        background-color: #73c574;border: #73c574 solid 1px;
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
                <el-breadcrumb-item><a href="welcome.ftl" style="color:#fff;">主页</a></el-breadcrumb-item>
                <el-breadcrumb-item id="spanY">员工管理</el-breadcrumb-item>
            </el-breadcrumb>
        </el-header>

        <el-main >
            <div style="height: 70px;display: flex;flex-direction: row;align-items: center;">
                <el-input v-model="highSearch" placeholder="高级搜索" style="width: 200px;margin-right: 10px;"></el-input>
                <el-button type="success" icon="el-icon-search" id="button" @click="searchFun">搜索</el-button>
                <el-button type="success" icon="el-icon-plus" id="button" @click="dialogFormVisible = true">新增</el-button>
            </div>
            <el-table
                    :data="list"
                    style="width: 100%;">
                <el-table-column
                        prop="id"
                        label="序号">
                </el-table-column>
                <el-table-column
                        prop="employeeNo"
                        label="员工编号">
                </el-table-column>
                <el-table-column
                        prop="employeeName"
                        label="姓名">
                </el-table-column>
                <el-table-column
                        prop="job"
                        label="职位">
                </el-table-column>
                <el-table-column
                        prop="date"
                        label="入职时间">
                </el-table-column>
                <el-table-column
                        prop="sal"
                        label="薪资">
                </el-table-column>
                <el-table-column
                        label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" type="primary"  @click="updateUI(scope.row)">修改</el-button>
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



    <el-dialog title="新增员工" :visible.sync="dialogFormVisible" width="30%">
        <el-form :model="form">
            <el-form-item label="员工编号" class="myformitem">
                <el-input v-model="form.employeeNo" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="姓名" class="myformitem">
                <el-input v-model="form.employeeName" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="职位" class="myformitem">
                <el-input v-model="form.job" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="入职时间" class="myformitem">
                <el-input v-model="form.date" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="薪资" class="myformitem">
                <el-input v-model="form.sal" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible = false">取 消</el-button>
            <el-button type="primary" @click="add">确定添加</el-button>
        </div>
    </el-dialog>


    <el-dialog title="修改用户" :visible.sync="dialogUpdateVisible" width="30%">
        <el-form :model="updateForm">
            <el-form-item label="员工编号" class="myformitem">
                <el-input v-model="updateForm.employeeNo" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="姓名" class="myformitem">
                <el-input v-model="updateForm.employeeName" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="职位" class="myformitem">
                <el-input v-model="updateForm.job" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="入职时间"  class="myformitem">
                <el-input v-model="updateForm.date" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="薪资" class="myformitem">
                <el-input v-model="updateForm.sal" autocomplete="off" style="width: 200px"></el-input>
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
                employeeNo: '',
                employeeName: '',
                job: '',
                date: '',
                sal: ''
            },
            updateForm: {
                id:'',
                employeeNo: '',
                employeeName: '',
                job: '',
                date: '',
                sal: ''
            },
            updateFormName : ''
        },
        methods:{
            getList() {
                var self = this;
                axios({
                    methods: 'post',
                    url: '/company/emp/getList',
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
                var string = "此操作将永久删除 "+row.employeeName+" 员工, 是否继续?"
                this.$confirm(string, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    dangerouslyUseHTMLString: true

                }).then(() => {
                    var self = this;
                axios({
                    methods:'post',
                    url:'/company/emp/delete',
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
                if(this.form.employeeNo == undefined || this.form.employeeNo == ""){
                    this.$message({
                        type: 'info',
                        message: '员工编号未输入'});
                }else if(this.form.employeeName == undefined || this.form.employeeName == ""){
                    this.$message({
                        type: 'info',
                        message: '员工姓名未输入'});
                }else if(this.form.job == undefined || this.form.job == ""){
                    this.$message({
                        type: 'info',
                        message: '职位未输入'});
                }else if(this.form.date == undefined || this.form.date == ""){
                    this.$message({
                        type: 'info',
                        message: '入职时间未输入'});
                }else if(this.form.sal == undefined || this.form.sal == ""){
                    this.$message({
                        type: 'info',
                        message: '薪资未输入'});
                }else{
                    var self = this;
                    axios({
                        methods:'post',
                        url:'/company/emp/addAndUpdate',
                        params :{
                            form : this.form
                        }
                    }).then((request)=>{
                        if(request.data === 'success'){
                        this.$message({
                            type: 'success',
                            message: '添加成功!'
                        });
                        this.getList();
                        this.form.employeeNo = "";
                        this.form.employeeName = "";
                        this.form.sal = "";
                        this.form.date = "";
                        this.form.job = "";
                        this.dialogFormVisible = false;
                    }else{
                        this.$message({
                            type: 'info',
                            message: '添加失败,资源名已存在！'
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
                this.updateForm.job = row.job;
                this.updateForm.employeeName = row.employeeName;
                this.updateForm.employeeNo = row.employeeNo;
                this.updateForm.date = row.date;
                this.updateForm.sal = row.sal;
                this.updateFormName = row.employeeNo;
                this.dialogUpdateVisible = true;
            },
            handleUpdate(){
                if(this.updateForm.employeeNo == undefined || this.updateForm.employeeNo == ""){
                    this.$message({
                        type: 'info',
                        message: '员工编号未输入'});
                }else if(this.updateForm.employeeName == undefined || this.updateForm.employeeName == ""){
                    this.$message({
                        type: 'info',
                        message: '员工姓名未输入'});
                }else if(this.updateForm.job == undefined || this.updateForm.job == ""){
                    this.$message({
                        type: 'info',
                        message: '职位未输入'});
                }else if(this.updateForm.date == undefined || this.updateForm.date == ""){
                    this.$message({
                        type: 'info',
                        message: '入职时间未输入'});
                }else if(this.updateForm.sal == undefined || this.updateForm.sal == ""){
                    this.$message({
                        type: 'info',
                        message: '薪资未输入'});
                }else{
                    var self = this;
                    axios({
                        methods:'post',
                        url:'/company/emp/addAndUpdate',
                        params :{
                            form : this.updateForm,
                            updateName : this.updateFormName
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
            }
        },
        mounted() {
            this.getList();
        },
    })
</script>
</body>

</html>
