package com.cs.project.utils;

/**
 * @Auther: Xu ChengSi
 * @Date: 2019/11/29
 * @Description: 用一句来描述这个类的作用
 * @version: 1.0
 */
public class ResultFactory {
    public static Result  buildSuccessResult(Object data) {
        return buildResult(ResultCode.SUCCESS, "成功", data);
    }

    public static Result  buildFailResult(String message) {
        return buildResult(ResultCode.FAIL, message, null);
    }

    public static Result  buildResult(ResultCode resultCode, String message, Object data) {
        return buildResult(resultCode.code, message, data);
    }

    public static Result buildResult(int resultCode, String message, Object data) {
        return new Result(resultCode, message, data);
    }
}