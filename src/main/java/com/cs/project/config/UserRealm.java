package com.cs.project.config;

import com.cs.project.bean.Role;
import com.cs.project.bean.User;
import com.cs.project.dao.UserDao;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Set;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/11/28
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
public class UserRealm extends AuthorizingRealm {

    @Autowired
    private UserDao userDao;

    /**
     * 执行   授权逻辑
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //获取认证成功的用户名称
        String username = (String) principalCollection.getPrimaryPrincipal();
        //查询用户对应的角色
        Set<String> roles = userDao.selectRnameByUsername(username);
        //如果是管理员，将获取所有角色
        if(roles.contains("admin")){
            roles = userDao.selectRname();
        }
        //执行授权逻辑
        AuthorizationInfo info = new SimpleAuthorizationInfo(roles);
        return info;
    }

    /**
     * 执行   认证  逻辑
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //获取传递过来的对象
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        //获取对应的名称
        String username = token.getUsername();
        //查询是否有对应的数据
        //这里并不是直接将账号和密码发送过去，只是发送账号，避免用户不清楚是账号错了还是密码错了
        User user = userDao.selectUserByUsername(username);
        if(user == null){
            throw new UnknownAccountException("用户名不存在");
        }
        if(user.getStatus() == 0){
            throw new LockedAccountException("该用户已被锁定");
        }
        //以下步骤比较重要
        Object principal = username;
        //这个是数据库中的密码，传递过去做比较
        Object credentials = user.getPassword();
        AuthenticationInfo info = new SimpleAuthenticationInfo(principal,credentials,super.getName());
        return info;
    }
}
