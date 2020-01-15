package com.cs.project.controller;

import com.cs.project.bean.Message;
import com.cs.project.bean.User;
import com.cs.project.dao.MessageDao;
import com.cs.project.dao.UserDao;
import net.sf.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.*;
import javax.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/12/30
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
@Controller
public class MessageController {

    @Autowired
    private MessageDao messageDao;
    @Autowired
    private UserDao userDao;

    @RequestMapping("/normal/message/getMessageList")
    @ResponseBody
    public Page<Message> queryAllByHighSearch(Integer currentPage, Integer pageSize, String highSearch){
        System.out.println("来到getMessageList");
        Subject currentUser = SecurityUtils.getSubject();
        String username = (String)currentUser.getPrincipal();
        Specification<Message> spec  = new Specification<Message>() {
            @Override
            public Predicate toPredicate(Root<Message> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Path<Message> sender = root.get("sender");
                Path<Message> theme = root.get("theme");
                Path<Message> date = root.get("date");
                Path<Message> receiver = root.get("receiver");
                Predicate predicate = criteriaBuilder.and(
                        criteriaBuilder.equal(receiver.as(String.class),username),
                        criteriaBuilder.or(
                                criteriaBuilder.like(sender.as(String.class), "%" + highSearch + "%"),
                                criteriaBuilder.like(theme.as(String.class), "%" + highSearch + "%"),
                                criteriaBuilder.like(date.as(String.class), "%" + highSearch + "%"))
                );
                return predicate;
            }
        };
        //说明是增删改方法，非条件查询
        Sort sort = Sort.by(Sort.Direction.DESC,"date");
        Pageable pageable =  PageRequest.of(currentPage-1,pageSize,sort);
        Page<Message> page = messageDao.findAll(spec,pageable);
        return page;
    }



    @RequestMapping("/normal/message/getNoSeessMessageSize")
    @ResponseBody
    public Map<String,Object> getNoSeessMessageSize(){
        Map<String,Object > map = new HashMap<>();
        Subject currentUser = SecurityUtils.getSubject();
        String username = (String)currentUser.getPrincipal();
        map.put("size",messageDao.findMessagesByReceiverAndStatus(username,0).size());
        return map;
    }

    @RequestMapping("/normal/message/delete")
    @ResponseBody
    public String deleteMessage(Integer id){
        messageDao.deleteById(id);
        return "success";
    }

    @RequestMapping("/normal/message/deleteAllMessage")
    @ResponseBody
    @Transactional
    public String deleteAllMessage(){
        Subject currentUser = SecurityUtils.getSubject();
        String username = (String)currentUser.getPrincipal();
        messageDao.deleteAllMessage(username);
        return "success";
    }

    @RequestMapping("/normal/message/makeAllMessageIsSee")
    @ResponseBody
    @Transactional
    public String makeAllMessageIsSee(){
        Subject currentUser = SecurityUtils.getSubject();
        String username = (String)currentUser.getPrincipal();
        messageDao.updateAllMessageIsSee(username);
        return "success";
    }

    @RequestMapping("/normal/message/makeMessageNoSee")
    @ResponseBody
    @Transactional
    public String makeMessageNoSee(Integer id){
        messageDao.updateMessageNoSee(id);
        return "success";
    }

    @RequestMapping("/normal/message/makeMessageIsSee")
    @ResponseBody
    @Transactional
    public String makeMessageIsSee(Integer id){
        messageDao.updateMessageIsSee(id);
        return "success";
    }

    @RequestMapping("/normal/message/reply")
    @ResponseBody
    public String reply(String message){
        JSONObject jsonobject = JSONObject.fromObject(message);
        Message messagebean = (Message)JSONObject.toBean(jsonobject,Message.class);
        messagebean.setDate( new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()).toString());
        if(userDao.findUserByUsername(messagebean.getReceiver()) == null){
            //如果不存在瞎写的用户名，则直接不发
        }else{
            messageDao.save(messagebean);
        }
        return "success";
    }

    @RequestMapping("/normal/message/sendMessage")
    @ResponseBody
    public String sendMessage(String users,String theme,String content){
        Subject currentUser = SecurityUtils.getSubject();
        String sender = (String)currentUser.getPrincipal();
        String[] receivers = users.split(",");
        for(String rname : receivers){
            if(userDao.findUserByUsername(rname) == null){
                //如果不存在瞎写的用户名，则直接不发
            }else{
                Message messagebean = new Message();
                messagebean.setDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()).toString());
                messagebean.setStatus(0);
                messagebean.setContent(content);
                messagebean.setTheme(theme);
                messagebean.setSender(sender);
                messagebean.setReceiver(rname);
                messageDao.save(messagebean);
            }
        }
        return "success";
    }


    public static void main(String args[]){
    }
}
