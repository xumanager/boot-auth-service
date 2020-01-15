package com.cs.project.dao;



import com.cs.project.bean.Resource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/11/25
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
public interface ResourceDao extends JpaRepository<Resource,Integer>, JpaSpecificationExecutor<Resource> {
    public Resource findResourceByKeyname(String keyname);
}
