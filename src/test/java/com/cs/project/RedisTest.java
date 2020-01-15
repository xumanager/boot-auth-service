package com.cs.project;

import com.cs.project.bean.User;
import com.cs.project.dao.UserDao;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.test.context.junit4.SpringRunner;
import redis.clients.jedis.Jedis;

import java.util.List;

/**
 * @Auther: Xu ChengSi
 * @Date: 2020/1/4
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */

@RunWith(SpringRunner.class)
@SpringBootTest(classes =Application.class )
public class RedisTest {

    @Autowired
    private RedisTemplate<String,String> redisTemplate;


    @Test
    public void tesr() throws JsonProcessingException {
        String userListJson = redisTemplate.boundValueOps("user.findAll").get();
        if(userListJson == null){
            System.out.println("数据不存在");
            redisTemplate.boundValueOps("user.findAll").set("12312312");
            System.out.println("数据中已查询");
        }else{
            System.out.println("数据存在");

        }
        System.out.println(userListJson);

    }
}
