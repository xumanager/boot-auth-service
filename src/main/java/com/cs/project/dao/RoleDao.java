package com.cs.project.dao;


import com.cs.project.bean.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/11/25
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
public interface RoleDao extends JpaRepository<Role,Integer>, JpaSpecificationExecutor<Role> {

    public Role findRoleByRolename(String username);

    @Modifying
    @Query(value="delete from user_role where rid = ?",nativeQuery = true)
    public void deleteUserRoleTableByRoleId(int id);
}
