package com.cs.project.dao;



import com.cs.project.bean.Message;
import com.cs.project.bean.Resource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/11/25
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
public interface MessageDao extends JpaRepository<Message,Integer>, JpaSpecificationExecutor<Message> {
    public List<Message> findMessagesByReceiverAndStatus(String name,int status);

    @Modifying
    @Query(value = "delete from message where receiver = ?",nativeQuery = true)
    public void deleteAllMessage(String username);


    @Modifying
    @Query(value = "update  message set status = 1 where receiver = ?",nativeQuery = true)
    public void updateAllMessageIsSee(String username);

    @Modifying
    @Query(value = "update  message set status = 1 where id = ?",nativeQuery = true)
    public void updateMessageIsSee(Integer id);

    @Modifying
    @Query(value = "update  message set status = 0 where id = ?",nativeQuery = true)
    public void updateMessageNoSee(Integer id);
}
