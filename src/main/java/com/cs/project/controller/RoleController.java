package com.cs.project.controller;

import com.cs.project.bean.Role;
import com.cs.project.dao.RoleDao;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.*;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/12/27
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
@Controller
public class RoleController {
    @Autowired
    private RoleDao roleDao;

    //高级检索
    @RequestMapping("/auth/role/getList")
    @ResponseBody
    public Page<Role> queryAllByHighSearch(Integer currentPage, Integer pageSize, String highSearch){
        Specification<Role> spec  = new Specification<Role>() {
            @Override
            public Predicate toPredicate(Root<Role> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Path<Role> rolename = root.get("rolename");
                Path<Role> remark = root.get("remark");
                Path<Role> status = root.get("status");
                return criteriaBuilder.or(
                        criteriaBuilder.like(rolename.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(remark.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(status.as(String.class), "%" + highSearch + "%"));
            }
        };
        //说明是增删改方法，非条件查询
        Sort sort = Sort.by(Sort.Direction.ASC,"sortnum");
        Pageable pageable =  PageRequest.of(currentPage-1,pageSize,sort);
        Page<Role> page = roleDao.findAll(spec,pageable);
        return page;
    }

    //修改方法，与保存方法调用同一个方法：当有ID为修改，没ID为保存
    @RequestMapping("/auth/role/addAndUpdate")
    @ResponseBody
    public String addAndUpdate(String role,String rolename){
        JSONObject jsonobject = JSONObject.fromObject(role);
        Role addRole = (Role)JSONObject.toBean(jsonobject,Role.class);

        //情况1：修改方法且名字没有被改
        if(rolename != null){
            if(rolename.equals(addRole.getRolename())){
                //说明名字没有被改
                roleDao.save(addRole);
                return "success";
            }
        }
        //情况2：修改方法名字修改了或者添加方法
        Role tempRole = roleDao.findRoleByRolename(addRole.getRolename());
        if(tempRole == null){
            //保存或者修改
            roleDao.save(addRole);
            return "success";
        }else{
            return "error";
        }
    }

    @RequestMapping("/auth/role/getAllRole")
    @ResponseBody
    public List<Role> getAllRole(){
        Sort sort = Sort.by(Sort.Direction.ASC,"sortnum");
        return roleDao.findAll(sort);
    }
    @RequestMapping("/auth/role/delete")
    @ResponseBody
    @Transactional
    public String delete(int id){
        //删除之前需要先删除多对多表中的数据
        roleDao.deleteUserRoleTableByRoleId(id);
        //在查询这个角色并删除，其实也没必要
        Role role = roleDao.getOne(id);
        roleDao.delete(role);
        return "success";

    }
}
