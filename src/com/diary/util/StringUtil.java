package com.diary.util;

import java.util.Date;
import java.util.List;

/**
 * 实用工具类
 * @author Lenovo
 *
 */
public class StringUtil {
	
	/**
	 * 将给定的list按照指定的分隔符分割成字符串返回
	 * @param list
	 * @param split
	 * @return
	 */
	public static String joinString(List<Long> list,String split){
		String ret = "";
		for(Long l:list){
			ret += l + split;
		}
		if(!"".equals(ret)){
			ret = ret.substring(0,ret.length() - split.length());
		}
		return ret;
	}
	
	
	/**
	   *     生成用户编号的方法
	 * @param prefix
	 * @param suffix
	 * @return
	 */
	public static String generateUn(String prefix,String suffix){
		return prefix + new Date().getTime() + suffix;
	}
	
	
	/**
	 * 字符串前后加%
	 * @param str
	 * @return
	 */
	public static String formatLike(String str) {
		if(isNotEmpty(str)) {
			return "%" + str + "%";
		}
		return null;
	}
	
	/**
	 * 判断字符串是否为空
	 */
	public static boolean isNotEmpty(String str) {
		if(str != null && !"".equals(str.trim())) {
			return true;
		}
		return false;
	}
}
