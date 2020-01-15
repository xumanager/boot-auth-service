<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>资源列表</title>
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
                <el-breadcrumb-item>资源管理</el-breadcrumb-item>
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
                        prop="keyname"
                        label="访问链接">
                </el-table-column>
                <el-table-column
                        prop="remark"
                        label="链接说明">
                </el-table-column>
                <el-table-column
                        prop="classify"
                        label="分类">
                </el-table-column>
                <el-table-column
                        prop="val"
                        label="允许资源">
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



    <el-dialog title="新增资源" :visible.sync="dialogFormVisible" width="30%">
        <el-form :model="form">
            <el-form-item label="资源" class="myformitem">
                <el-input v-model="form.keyname" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="允许对象" class="myformitem">
                <el-input v-model="form.val" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="说明" class="myformitem">
                <el-input v-model="form.remark" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="分类" class="myformitem">
                <el-input v-model="form.classify" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="排序号" class="myformitem">
                <el-input v-model="form.sortnum" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible = false">取 消</el-button>
            <el-button type="primary" @click="add">确定添加</el-button>
        </div>
    </el-dialog>


    <el-dialog title="修改用户" :visible.sync="dialogUpdateVisible" width="30%">
        <el-form :model="updateForm">
            <el-form-item label="资源" class="myformitem">
                <el-input v-model="updateForm.keyname" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="允许对象" class="myformitem">
                <el-input v-model="updateForm.val" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="说明" class="myformitem">
                <el-input v-model="updateForm.remark" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="分类" class="myformitem">
                <el-input v-model="updateForm.classify" autocomplete="off" style="width: 200px"></el-input>
            </el-form-item>
            <el-form-item label="排序号" class="myformitem">
                <el-input v-model="updateForm.sortnum" autocomplete="off" style="width: 200px"></el-input>
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
                keyname: '',
                val: '',
                sortnum: '',
                status: '',
                remark: '',
                classify: '',
            },
            updateForm: {
                id:'',
                keyname: '',
                val: '',
                sortnum: '',
                status: '',
                remark: '',
                classify: '',
            },
            updateFormName : ''
        },
        methods:{
            getList() {
                var self = this;
                axios({
                    methods: 'post',
                    url: '/auth/resource/getList',
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
                var string = "此操作将永久删除 "+row.key+" 资源, 是否继续?"
                this.$confirm(string, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    dangerouslyUseHTMLString: true

                }).then(() => {
                    var self = this;
                axios({
                    methods:'post',
                    url:'/auth/resource/delete',
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
                if(this.form.keyname == undefined || this.form.keyname == ""){
                    this.$message({
                        type: 'info',
                        message: '资源链接未输入'});
                }else if(this.form.val == undefined || this.form.val == ""){
                    this.$message({
                        type: 'info',
                        message: '允许对象未输入'});
                }else if(this.form.sortnum == undefined || this.form.sortnum == ""){
                    this.$message({
                        type: 'info',
                        message: '排序号未输入'});
                }else if(this.form.remark == undefined || this.form.remark == ""){
                    this.$message({
                        type: 'info',
                        message: '资源说明未输入'});
                }else if(this.form.classify == undefined || this.form.classify == ""){
                    this.$message({
                        type: 'info',
                        message: '分类未输入'});
                }else{
                    var self = this;
                    this.form.status = 0;
                    axios({
                        methods:'post',
                        url:'/auth/resource/addAndUpdate',
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
                        this.form.classify = "";
                        this.form.keyname = "";
                        this.form.val = "";
                        this.form.remark = "";
                        this.form.status = "";
                        this.form.sortnum = "";
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
                this.updateForm.classify = row.classify;
                this.updateForm.val = row.val;
                this.updateForm.keyname = row.keyname;
                this.updateForm.sortnum = row.sortnum;
                this.updateForm.remark = row.remark;
                this.updateForm.status = row.status;
                this.updateFormName = row.keyname;
                this.dialogUpdateVisible = true;
            },
            handleUpdate(){
                if(this.updateForm.keyname == undefined || this.updateForm.keyname == ""){
                    this.$message({
                        type: 'info',
                        message: '资源链接未输入'});
                }else if(this.updateForm.val == undefined || this.updateForm.val == ""){
                    this.$message({
                        type: 'info',
                        message: '允许对象未输入'});
                }else if(this.updateForm.sortnum == undefined || this.updateForm.sortnum == ""){
                    this.$message({
                        type: 'info',
                        message: '排序号未输入'});
                }else if(this.updateForm.remark == undefined || this.updateForm.remark == ""){
                    this.$message({
                        type: 'info',
                        message: '资源说明未输入'});
                }else{
                    var self = this;
                    axios({
                        methods:'post',
                        url:'/auth/resource/addAndUpdate',
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
            },
            changeSwitch(row){

                var self = this;
                axios({
                    methods:'post',
                    url:'/auth/resource/addAndUpdate',
                    params :{
                        form : row,
                        updateName : row.keyname
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
