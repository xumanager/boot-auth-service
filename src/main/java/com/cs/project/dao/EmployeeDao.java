package com.cs.project.dao;

import com.cs.project.bean.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/11/25
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
public interface EmployeeDao extends JpaRepository<Employee,Integer>, JpaSpecificationExecutor<Employee> {
    public Employee findEmployeeByEmployeeNo(String employeeNo);


    @Query(value = "SELECT * FROM t_employee e RIGHT JOIN USER u ON e.id = u.eid;",nativeQuery = true)
    public List<Employee> findNoEmployee();
}
