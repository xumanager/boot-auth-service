package com.cs.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/12/27
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
@Controller
public class CompanyMainController {

    @RequestMapping("/company/emp/empList")
    public String toEmpList(){
            return "company/empList";
    }


}
