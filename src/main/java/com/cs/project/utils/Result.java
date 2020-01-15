package com.cs.project.utils;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/11/29
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
public class Result {
    /**
     * 响应状态码
     */
    private int code;
    /**
     * 响应提示信息
     */
    private String message;
    /**
     * 响应结果对象
     */
    private Object loginInfo;

    public Result(int code, String message, Object loginInfo) {
        this.code = code;
        this.message = message;
        this.loginInfo = loginInfo;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getLoginInfo() {
        return loginInfo;
    }

    public void setLoginInfo(String loginInfo) {
        this.loginInfo = loginInfo;
    }
}