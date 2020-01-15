package com.cs.project;

import com.cs.project.bean.Role;
import com.cs.project.dao.RoleDao;
import com.cs.project.dao.UserDao;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DemoApplicationTests {

    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Test
//    @Transactional
    void contextLoads() {


    }

}
