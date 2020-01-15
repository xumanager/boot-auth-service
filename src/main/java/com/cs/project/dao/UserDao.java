package com.cs.project.dao;

import com.cs.project.bean.Role;
import com.cs.project.bean.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Set;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/11/25
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
public interface UserDao extends JpaRepository<User,Integer>, JpaSpecificationExecutor<User> {

    @Query(value = "select * from user where username=?",nativeQuery = true)
    public User selectUserByUsername(String username);

    @Query(value = "SELECT  r.rolename FROM USER u LEFT JOIN user_role ur ON ur.uid = u.id LEFT JOIN role r ON ur.rid = r.id WHERE u.username = ? AND r.status = 1;" , nativeQuery = true)
    public Set<String> selectRnameByUsername(String username);

    @Query( value = "select rolename from role where status = 1",nativeQuery = true)
    public Set<String> selectRname();


    public User findUserByUsername(String username);

    @Query( value = "select * from user where eid = ?",nativeQuery = true)
    public User findUserByEmpId(int id);

    @Modifying
    @Query( value = "insert into user_role values(null,?,?,1)",nativeQuery = true)
    public void giveUserARole(int uid,int rid);

    @Modifying
    @Query( value = "delete from user_role where uid = ? and rid = ?",nativeQuery = true)
    public void repealUserARole(int uid,int rid);

    public User findUserByUsernameAndPasswordAndPhone(String username,String password,String phone);


    @Query( value = "SELECT r.id,r.rolename,r.remark,r.status,r.sortnum FROM role r  " +
            " RIGHT JOIN user_role ur ON ur.rid = r.id  " +
            " LEFT JOIN USER u ON ur.uid = u.id WHERE u.id = ?;",nativeQuery = true)
    public List<Role> findUserRolesByUserId(int id);
}
