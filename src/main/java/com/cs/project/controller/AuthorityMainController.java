package com.cs.project.controller;

import com.cs.project.bean.Employee;
import com.cs.project.bean.Role;
import com.cs.project.dao.RoleDao;
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
import java.util.List;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/12/26
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
@Controller
public class AuthorityMainController {


    @RequestMapping("/auth/authList")
    public String toAuthList(){
        return "authority/authList";
    }

    @RequestMapping("/auth/roleList")
    public String toRoleList(){
        return "authority/roleList";
    }

    @RequestMapping("/auth/userList")
    public String toUserList(){
        return "authority/userList";
    }

    @RequestMapping("/auth/welcome")
    public String toWelcome(){
        return "authority/welcome";
    }

    @RequestMapping("/auth/user_role")
    public String toUserRoleList(){
        return "authority/user_role";
    }


}
