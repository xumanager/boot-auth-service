package com.cs.project.controller;

import com.cs.project.bean.User;
import com.cs.project.dao.ResourceDao;
import com.cs.project.dao.RoleDao;
import com.cs.project.dao.UserDao;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.Map;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/12/3
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
@Controller
public class MainController {

    @Autowired
    private ResourceDao resourceDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;


    @RequestMapping("/index")
    public String toIndex(){
        return "index";
    }

    @RequestMapping("/company/index")
    public String toEmployee(){
        return "company/index";
    }


    @RequestMapping("/emp/clockIn")
    @ResponseBody
    public String toClockIn(){
        return "打卡页面";
    }

    @RequestMapping("/emp/applyAuth")
    @ResponseBody
    public String toApplyAuth(){
        return "申请权限页面";
    }

    @RequestMapping("/account/index")
    @ResponseBody
    public String toAccountIndex(){
        return "财务管理页面";
    }

    @RequestMapping("/auth/index")
    public String toAuthIndex(){
        return "authority/index";
    }

    @RequestMapping("/loginUI")
    public ModelAndView toLoginUI(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("message","");
        modelAndView.setViewName("login");
        return modelAndView;
    }
    @RequestMapping("/normal/message/index")
    public ModelAndView toMyMessage(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("messageBox");
        return modelAndView;
    }
    @RequestMapping("/index_home")
    public ModelAndView toIndexHome(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("index_home");
        return modelAndView;
    }


    @RequestMapping("/introduce_system")
    public ModelAndView toIntroduceSystem(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("introduceSystem");
        return modelAndView;
    }

    @RequestMapping("/normal/logout")
    public ModelAndView logout(){
        System.out.println("执行了登出方法");
        Subject currentUser = SecurityUtils.getSubject();
        currentUser.logout();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("message","");
        modelAndView.setViewName("index_home");
        return modelAndView;
    }

    @RequestMapping("/axiosLogin")
    @ResponseBody
    public Map<String,Object> axiosLogin(String username, String password){
        User existUser = userDao.findUserByUsername(username);
        Map<String,Object> map = new HashMap<>();
        if(existUser != null){
            if(existUser.getPassword().equals(password)){
                if(existUser.getStatus() == 1){
                    map.put("status","1");
                    map.put("message","登录成功");
                }else{
                    map.put("status","0");
                    map.put("message","账户已被冻结");
                }

            }else{
                map.put("status","0");
                map.put("message","密码错误");
            }
        }else{
            map.put("status","0");
            map.put("message","用户名不存在");
        }
        return map;
    }
    @RequestMapping("/axiosRegist")
    @ResponseBody
    @Transactional
    public Map<String,Object> axiosRigst(String username, String password,String phone,String email){
        User existUser = userDao.findUserByUsername(username);
        Map<String,Object> map = new HashMap<>();
        if(existUser != null){
            //说明用户名已经存在
            map.put("status","0");
            map.put("message","用户名已存在");
        }else{
           User regU = new User();
           regU.setUsername(username);
           regU.setPassword(password);
           regU.setPhone(phone);
           regU.setEmail(email);
           regU.setStatus(1);
           userDao.save(regU);

           //写死普通用户的ID
           userDao.giveUserARole(regU.getId(),21);
            map.put("status","1");
            map.put("message","注册成功");
        }
        return map;
    }

    @RequestMapping("/login")
    public ModelAndView login(String username, String password){
        System.out.println("执行了登录方法");
        //获取权限对象
        Subject currentUser = SecurityUtils.getSubject();
        ModelAndView modelAndView = new ModelAndView();
        //如果不成功就返回登录页面
        modelAndView.setViewName("login");
        //登录成功之后没有登出，不管账号密码是什么都是可以进入的
        if(!currentUser.isAuthenticated()){
            //创建账号密码对象
            UsernamePasswordToken token = new UsernamePasswordToken(username,password);
            token.setRememberMe(true);
            modelAndView.addObject("status","0");
            try {
                //执行登录
                currentUser.login(token);
                modelAndView.setViewName("index_home");
                modelAndView.addObject("status","1");
            } catch (UnknownAccountException e) {
                e.printStackTrace();
                modelAndView.addObject("message","账号不存在");
            } catch (IncorrectCredentialsException e) {
                e.printStackTrace();
                modelAndView.addObject("message","密码错误");
            } catch (LockedAccountException e) {
                e.printStackTrace();
                modelAndView.addObject("message","账号已被锁定");
            } catch (AuthenticationException e) {
                e.printStackTrace();
            }
        }

        return modelAndView;
    }


    @RequestMapping("/normal/updateUser")
    @ResponseBody
    public Map<String,Object> updateUserPassword(String phone,String oldPassword, String newPassword){
        Subject currentUser = SecurityUtils.getSubject();
        Map<String,Object> map = new HashMap<>();
        User user = userDao.findUserByUsernameAndPasswordAndPhone(currentUser.getPrincipal().toString(),oldPassword,phone);
        if(user == null){
            //手机号码或者旧密码出错
            map.put("status","0");
            map.put("message","手机号码或者旧密码有误");
        }else{
            user.setPassword(newPassword);
            userDao.save(user);
            map.put("status","1");
            map.put("message","修改成功");
        }
        return map;
    }
}
