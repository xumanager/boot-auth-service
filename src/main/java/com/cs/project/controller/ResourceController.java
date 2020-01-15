package com.cs.project.controller;

import com.cs.project.bean.Resource;
import com.cs.project.dao.ResourceDao;
import net.sf.json.JSONObject;
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

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/12/27
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
@Controller
public class ResourceController {
    @Autowired
    private ResourceDao resourceDao;

    //高级检索
    @RequestMapping("/auth/resource/getList")
    @ResponseBody
    public Page<Resource> queryAllByHighSearch(Integer currentPage, Integer pageSize, String highSearch){
        Specification<Resource> spec  = new Specification<Resource>() {
            @Override
            public Predicate toPredicate(Root<Resource> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Path<Resource> keyname = root.get("keyname");
                Path<Resource> val = root.get("val");
                Path<Resource> classify = root.get("classify");
                Path<Resource> remark = root.get("remark");
                return criteriaBuilder.or(
                        criteriaBuilder.like(classify.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(remark.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(keyname.as(String.class), "%" + highSearch + "%"),
                        criteriaBuilder.like(val.as(String.class), "%" + highSearch + "%"));
            }
        };
        //说明是增删改方法，非条件查询
        Sort sort = Sort.by(Sort.Direction.ASC,"sortnum");
        Pageable pageable =  PageRequest.of(currentPage-1,pageSize,sort);
        Page<Resource> page = resourceDao.findAll(spec,pageable);


        return page;
    }

    //修改方法，与保存方法调用同一个方法：当有ID为修改，没ID为保存
    @RequestMapping("/auth/resource/addAndUpdate")
    @ResponseBody
    public String addAndUpdate(String form,String updateName){
        JSONObject jsonobject = JSONObject.fromObject(form);
        Resource addBean = (Resource)JSONObject.toBean(jsonobject,Resource.class);
        //情况1：修改方法且名字没有被改
        if(updateName != null){
            if(updateName.equals(addBean.getKeyname())){
                //说明名字没有被改
                resourceDao.save(addBean);
                return "success";
            }
        }
        //情况2：修改方法名字修改了或者添加方法
        Resource tempBean = resourceDao.findResourceByKeyname(addBean.getKeyname());
        if(tempBean == null){
            //保存或者修改
            resourceDao.save(addBean);
            return "success";
        }else{
            return "error";
        }
    }



    @RequestMapping("/auth/resource/delete")
    @ResponseBody
    public String delete(int id){
        System.out.println("id=="+id);
        Resource bean = resourceDao.getOne(id);
        resourceDao.delete(bean);
        return "success";

    }
}
