package com.cs.project.controller;

import com.cs.project.bean.Employee;
import com.cs.project.bean.Role;
import com.cs.project.dao.EmployeeDao;
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
import java.util.List;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/12/27
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
@Controller
public class EmployeeController {
    @Autowired
    private EmployeeDao employeeDao;

    //高级检索
    @RequestMapping("/company/emp/getList")
    @ResponseBody
    public Page<Employee> queryAllByHighSearch(Integer currentPage, Integer pageSize, String highSearch){
        Specification<Employee> spec  = new Specification<Employee>() {
            @Override
            public Predicate toPredicate(Root<Employee> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Path<Employee> employeeNo = root.get("employeeNo");
                Path<Employee> employeeName = root.get("employeeName");
                Path<Employee> job = root.get("job");
                Path<Employee> date = root.get("date");
                return criteriaBuilder.or(
                        criteriaBuilder.like(employeeNo.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(employeeName.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(job.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(date.as(String.class), "%" + highSearch + "%"));
            }
        };
        //说明是增删改方法，非条件查询
        Pageable pageable =  PageRequest.of(currentPage-1,pageSize);
        Page<Employee> page = employeeDao.findAll(spec,pageable);
        return page;
    }

    //修改方法，与保存方法调用同一个方法：当有ID为修改，没ID为保存
    @RequestMapping("/company/emp/addAndUpdate")
    @ResponseBody
    public String addAndUpdate(String form,String updateName){
        JSONObject jsonobject = JSONObject.fromObject(form);
        Employee addBean = (Employee)JSONObject.toBean(jsonobject,Employee.class);
        System.out.println("resource==="+addBean);
        //情况1：修改方法且名字没有被改
        if(updateName != null){
            if(updateName.equals(addBean.getEmployeeNo())){
                //说明名字没有被改
                employeeDao.save(addBean);
                return "success";
            }
        }
        //情况2：修改方法名字修改了或者添加方法
        Employee tempBean = employeeDao.findEmployeeByEmployeeNo(addBean.getEmployeeNo());
        if(tempBean == null){
            //保存或者修改
            employeeDao.save(addBean);
            return "success";
        }else{
            return "error";
        }
    }

    @RequestMapping("/company/emp/getAllEmployee")
    @ResponseBody
    public List<Employee> getAllEmployee(){
        Sort sort = Sort.by(Sort.Direction.ASC,"employeeNo");
        return employeeDao.findAll(sort);
    }

    @RequestMapping("/company/emp/getNoEmployee")
    @ResponseBody
    public List<Employee> getNoEmployee(){
        return employeeDao.findNoEmployee();
    }

    @RequestMapping("/company/emp/delete")
    @ResponseBody
    public String delete(int id){
        System.out.println("id=="+id);
        Employee bean = employeeDao.getOne(id);
        employeeDao.delete(bean);
        return "success";

    }
}
