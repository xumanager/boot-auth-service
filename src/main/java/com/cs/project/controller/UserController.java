package com.cs.project.controller;

import com.cs.project.bean.Employee;
import com.cs.project.bean.Role;
import com.cs.project.bean.User;
import com.cs.project.dao.EmployeeDao;
import com.cs.project.dao.RoleDao;
import com.cs.project.dao.UserDao;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.*;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/12/27
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
@Controller
public class UserController {
    @Autowired
    private UserDao userDao;
    @Autowired
    private EmployeeDao employeeDao;

    //高级检索
    @RequestMapping("/auth/user/getList")
    @ResponseBody
    public Page<User> queryAllByHighSearch(Integer currentPage, Integer pageSize, String highSearch){
        Specification<User> spec  = new Specification<User>() {
            @Override
            public Predicate toPredicate(Root<User> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Path<User> username = root.get("username");
                Path<User> password = root.get("password");
                Path<User> phone = root.get("phone");
                Path<User> email = root.get("email");
                return criteriaBuilder.or(
                        criteriaBuilder.like(username.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(phone.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(email.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(password.as(String.class), "%" + highSearch + "%"));
            }
        };
        //说明是增删改方法，非条件查询
        Pageable pageable =  PageRequest.of(currentPage-1,pageSize);
        Page<User> page = userDao.findAll(spec,pageable);
        return page;
    }


    //高级检索
    @RequestMapping("/auth/user/getAll")
    @ResponseBody
    public List<User> getList(){
        List<User> list = userDao.findAll();
        return list;
    }



    //修改方法，与保存方法调用同一个方法：当有ID为修改，没ID为保存
    @RequestMapping("/auth/user/addAndUpdate")
    @ResponseBody
    @Transactional
    public Map<String,Object> addAndUpdate(String user,String updateName){
        JSONObject jsonobject = JSONObject.fromObject(user);
        Map<String,Object> map = new HashMap<>();
        User addBean = (User)JSONObject.toBean(jsonobject,User.class);

        List<Role> realRoles = new ArrayList<>();
        //因为User里面有数组，json数据不好转换
        List<Role> roles = addBean.getRoleSet();
        for(Object r : roles){
            Role rr =  (Role)JSONObject.toBean(JSONObject.fromObject(r),Role.class);
            realRoles.add(rr);
        }
        if(realRoles.size() > 0){
            addBean.setRoleSet(realRoles);
        }else{
            realRoles = null;
        }


        //因为是需要级联操作，这代码是保证程序正常，代价是发送一条修改员工语句
        if(addBean.getEmployee() != null){
            Employee empl = employeeDao.findEmployeeByEmployeeNo(addBean.getEmployee().getEmployeeNo());
            addBean.setEmployee(empl);
        }

        //情况1：修改方法
        if(updateName != null){
            //用户名没有被改
            if(updateName.equals(addBean.getUsername())){
                userDao.save(addBean);
                map.put("status","1");
                return map;
            }
        }
        //添加方法
        User tempBean = userDao.findUserByUsername(addBean.getUsername());
        if(tempBean == null){
            //保存成功
            userDao.save(addBean);
            map.put("status","1");
            return map;
        }else{
            map.put("status","0");
            map.put("message","用户名已存在");
            return map;
        }
    }



    @RequestMapping("/auth/user/delete")
    @ResponseBody
    public String delete(int id){
        System.out.println("id=="+id);
        User bean = userDao.getOne(id);
        userDao.delete(bean);
        return "success";

    }

    @RequestMapping("/auth/user/giveRole")
    @ResponseBody
    @Transactional
    public String giveRole(int uid,int rid){
        userDao.giveUserARole(uid,rid);
        return "success";

    }
    @RequestMapping("/auth/user/repealRole")
    @ResponseBody
    @Transactional
    public String repealRole(int uid,int rid){
        userDao.repealUserARole(uid,rid);
        return "success";

    }
}
