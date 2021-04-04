package com.diary.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.diary.entity.Admin;

/**
 * 登陆过滤 拦截器
 * @author Lenovo
 *
 */
public class LoginInterceptor  implements HandlerInterceptor{

	//@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	//@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	//@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		// TODO Auto-generated method stub
		String url = request.getRequestURI();
		
		//System.out.println("进入拦截器url = " + url);
		Object user = request.getSession().getAttribute("user");
		//System.out.println(user);
		if(user == null){
			//表示未登陆或者登陆状态失效
			//System.out.println("未登录或登陆失效= " + url);
			/* request.getContextPath() 获取网站根目录 */
			response.sendRedirect(request.getContextPath() + "/system/login");
			/*
			 * if("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))){
			 * //ajax���� Map<String, String> ret = new HashMap<String, String>();
			 * ret.put("type", "error"); ret.put("msg", "登陆状态失效，请重新登录!");
			 * response.getWriter().write(JSONObject.fromObject(ret).toString()); return
			 * false; } response.sendRedirect(request.getContextPath() + "/system/login");
			 */
			return false;
		}
		return true;
	}

}
