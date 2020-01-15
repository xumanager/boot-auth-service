package com.cs.project.config;

import com.cs.project.bean.Resource;
import com.cs.project.dao.ResourceDao;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.Sort;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/11/28
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
@Configuration
public class ShiroConfig {

    @Autowired
    //请求资源操作dao
    private ResourceDao resourceDao;

    //创建ShiroFilterFactoryBean
    @Bean("shiroFilter")
    public ShiroFilterFactoryBean getShiroFilterFactoryBean(@Qualifier("securityManager") DefaultWebSecurityManager securityManager){
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        //设置安全管理器
        shiroFilterFactoryBean.setSecurityManager(securityManager);
        /*
        *   设置内置**过滤器**非常重要
        */
        //LinkdHashMap是必须的，保证元素有序，在shiro中顺序不可乱
        Map<String,String> filterMap = new LinkedHashMap<>();
        //获取数据库中的resource，里面存储对应   请求   需要的   角色，升序
        Sort sort = Sort.by(Sort.Direction.ASC,"sortnum");
        List<Resource> list = resourceDao.findAll(sort);
        for(Resource resource : list){
            //将数据添加到map中,状态为0的则不使用
            if(resource.getStatus() == 1){
                filterMap.put(resource.getKeyname(),resource.getVal());
            }
        }

        //这一步就是将所有需要过滤的请求和需要的资源绑定在一起
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterMap);

        return shiroFilterFactoryBean;
    }

    //创建DefaultWebSecurityManager
    @Bean("securityManager")
    public DefaultWebSecurityManager getDefaultWebSecurityManager(@Qualifier("userRealm") UserRealm userRealm){
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        //关联realm
        securityManager.setRealm(userRealm);
        return securityManager;
    }

    //创建Realm
    @Bean("userRealm")
    public UserRealm getRealm(){
        return new UserRealm();
    }
}