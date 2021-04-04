package com.diary.util;

import java.util.HashMap;
import java.util.Map;

/**
 *通用返回类
 * @author Lenovo
 *
 */

public class Msg {
	//状态码
	private int code;
	//提示信息
	private String msg;
	//用户要返回给浏览器的数据
	private Map<String,Object> datalist = new HashMap<String,Object>();
	
	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("处理成功");
		return result;
	}
	
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("处理失败");
		return result;
	}
	
	public Msg add(String key,Object value) {
		this.getDatalist().put(key,value);
		return this;
	}
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getDatalist() {
		return datalist;
	}
	public void setDatalist(Map<String, Object> datalist) {
		this.datalist = datalist;
	}
	
	
}
