package com.diary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.diary.entity.Admin;
/*import com.diary.page.Page;*/
import com.diary.service.AdminService;
import com.diary.util.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

//服务器返回json格式的数据    发送ajax请求进行用户分页数据的查询

/**
 * 用户（管理员）控制器
 * 
 * @author Lenovo
 *
 */
@RequestMapping("/admin") 
@Controller
public class AdminController {

	@Autowired
	public AdminService adminService;

	/**
	 * 管理员列表页
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list(ModelAndView model) {
		model.setViewName("admin/admin_list");
		return model;
	}

	/**
	 * 获取管理员列表
	 * 
	 * @param pn
	 * @param model
	 * @return
	 */
	@RequestMapping("/get_list")
	@ResponseBody
	// @ResponseBody自动把返回的对象转换为json字符串 @ResponseBody使用需要jackson包
	public Msg getUsersWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		//System.out.println("调用用户列表获取方法");
		// 使用分页插件 传入页码和每页的大小
		PageHelper.startPage(pn, 10);
		List<Admin> adminList = adminService.findList();
		// System.out.println("获取到的用户列表结果："+ userList);
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面 传入连续显示的页数5

		PageInfo pageInfo = new PageInfo(adminList, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * 模糊查询
	 * @param pn
	 * @param model
	 * @param keywords
	 * @return
	 */
	@RequestMapping(value = "/search/{keywords}",method = RequestMethod.GET)
	@ResponseBody
	public Msg adminSearch(@RequestParam(value = "pn", defaultValue = "1") Integer pn, 
			Model model,
			@PathVariable("keywords") String keywords) {
		//System.out.println("调用搜索方法keywords为：" + keywords);
		//System.out.println(keywords);		
		// 使用分页插件 传入页码和每页的大小
		PageHelper.startPage(pn, 10);
		//模糊查询
		
		  List<Admin> adminList = adminService.searchBywords(keywords); 
		/* System.out.println("模糊查询的结果：" + adminList); */
		  PageInfo pageInfo = new PageInfo(adminList, 5); 
		  return Msg.success().add("pageInfo", pageInfo);
	}

	/**
	 * 添加管理员
	 * 
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public Msg addAdmin(@RequestParam("username") String username, @RequestParam("password") String password,
			Admin admin) {
		/* System.out.println("用户 "+ user.getName()); */
		// System.out.println(name);

		String regName = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		String regPassword = "^[a-zA-Z0-9_-]{5,18}$";
		if (!username.matches(regName)) {
			return Msg.fail().add("user_msg", "用户名必须为2-5位中文或者5-16位英文和数字，下划线，中划线的组合");
		}
		if (!password.matches(regPassword)) {
			return Msg.fail().add("pass_msg", "密码必须为6-18位字母数字下划线中划线的组合");
		}

		Admin existAdmin = adminService.findByUserName(username);
		if (existAdmin != null) {
			return Msg.fail().add("user_msg", "用户名已存在");
		}
		adminService.add(admin);
		return Msg.success();
	}

	 /**
	  * 根据管理员id查询管理员
	  * @param id
	  * @return
	  */
	 @RequestMapping(value ="/{id}",method=RequestMethod.GET )
	 @ResponseBody
	 //从路径中获取id
	  public Msg getAdmin(@PathVariable("id") Integer id) {
		 Admin admin = adminService.findById(id);
		  return Msg.success().add("admin",admin);
	  }
	
	
	 /**
	  * 编辑管理员
	  * @param admin
	  * @return
	  */
	 @RequestMapping(value="/edit/{id}",method=RequestMethod.POST)
	 @ResponseBody 
	 public Msg edit(Admin admin) {
		// System.out.println("将要更新的数据："+admin);
		 adminService.edit(admin);
		 return Msg.success();
	 }
	 
	 /**
	      *     管理员删除(单个，批量删除)
	  * @param id
	  * @return
	  */
	 @RequestMapping(value="/delete/{ids}",method=RequestMethod.POST)
	 @ResponseBody 
	 public Msg deleteById(@PathVariable("ids") String ids) {
		 //System.out.println("选中的所有id:"+ ids);
		 if(ids.contains("-")) {
			 //批量删除
			 String idsString = "";
			 String[] str_ids = ids.split("-");
			
			  for(String string:str_ids) {
				  idsString += string + ",";
			  }
			//去除最后一个逗号
			idsString = idsString.substring(0,idsString.length()-1);
			//System.out.println("重新组装好的id字符串：" + idsString);
			if(adminService.deleteAll(idsString)<=0) {
				 return Msg.fail(); 
			}
		 }else {
			 Integer id = Integer.parseInt(ids);
			/* System.out.println("删除管理员" + id); */
			 if( adminService.deleteById(id)<=0) {
				  return Msg.fail(); 
			  }
		 }
		 return Msg.success(); 
	 }
}
