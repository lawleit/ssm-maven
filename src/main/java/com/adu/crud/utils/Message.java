package com.adu.crud.utils;

import java.util.HashMap;
import java.util.Map;

/**
 *
 */
public class Message {

    /**
     * code=200 success
     * 其他自定义
     */
    private int code;

    /**
     * 表示是否成功
     * TODO: Note that this is a special name.
     */
    private boolean isSuccess;

    /**
     * 返回提示信息
     */
    private String msg;

    /**
     * 返回前台数据
     */
    private Map<String,Object> maps = new HashMap<>();

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public boolean isSuccess() {
        return isSuccess;
    }

    public void setSuccess(boolean success) {
        isSuccess = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getMaps() {
        return maps;
    }

    public void setMaps(Map<String, Object> maps) {
        this.maps = maps;
    }

    /**
     * 成功返回
     * @return Message
     */
    public static Message getSuccess(){
        Message message = new Message();
        message.setCode(200);
        message.isSuccess = true;
        message.setMsg("操作成功");
        return message;
    }

    /**
     * 错误返回
     * @return Message
     */
    public static Message getError(){
        Message message = new Message();
        message.setCode(100);
        message.isSuccess = false;
        message.setMsg("操作失败");
        return message;
    }

    /**
     * 数据源添加数据
     * @param key 键
     * @param value 值
     * @return Message
     */
    public Message addAttribute(String key, Object value){
        maps.put(key, value);
        return this;
    }
}
