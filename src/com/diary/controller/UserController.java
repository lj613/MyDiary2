package com.diary.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.diary.entity.User;
import com.diary.service.UserService;
import com.diary.util.Msg;
import com.diary.util.StringUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 用户控制器
 * 
 * @author Lenovo
 *
 */
@RequestMapping("/user")
@Controller
public class UserController {

	@Autowired
	private UserService userService;

	/**
	 * 用户列表页
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list(ModelAndView model) {
		model.setViewName("user/user_list");
		return model;
	}
	
	@RequestMapping(value = "/personal", method = RequestMethod.GET)
	public ModelAndView personal(ModelAndView model) {
		model.setViewName("user/personal");
		return model;
	}
	
	/**
	 * 获取用户列表
	 * 
	 * @param pn
	 * @param model
	 * @return
	 */
	@RequestMapping("/get_list")
	@ResponseBody
	// @ResponseBody自动把返回的对象转换为json字符串 @ResponseBody使用需要jackson包
	public Msg getUsersWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model,
			HttpServletRequest request) {
		
		Object userType =  request.getSession().getAttribute("userType"); 
		
		if("2".equals(userType.toString())) {
			//是普通用户
			//System.out.println("普通用户");
			User loginedUser = (User)request.getSession().getAttribute("user");
			
			/* User user = userService.findByUserName(loginedUser.getUsername()); */
			 User user = userService.findById(loginedUser.getId().intValue()); 
			//System.out.println(user);
			 //List<User> userList;
			 List<User> userList = new ArrayList<User>();
			 userList.add(user);
			PageInfo pageInfo = new PageInfo(userList, 5);
			return Msg.success().add("pageInfo", pageInfo);
		}else {
			//System.out.println("调用用户列表获取方法");
			// 使用分页插件 传入页码和每页的大小
			PageHelper.startPage(pn, 6);
			List<User> userList = userService.findList();
			// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面 传入连续显示的页数5
			PageInfo pageInfo = new PageInfo(userList, 5);
			return Msg.success().add("pageInfo", pageInfo);
		}
		
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
		/* keywords ="%" + keywords +"%"; */
		//System.out.println(keywords);
		/*
		 * queryMap.put("username", "%"+username+"%");//模糊查询
		 */		// 使用分页插件 传入页码和每页的大小
		PageHelper.startPage(pn, 6);
		//模糊查询
		
		  List<User> userList = userService.searchBywords(keywords); 
		/* System.out.println("模糊查询的结果：" + adminList); */
		  PageInfo pageInfo = new PageInfo(userList, 5); 
		  return Msg.success().add("pageInfo", pageInfo);
	}

	/**
	 * 添加用户
	 * 
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public Msg addUser(@RequestParam("username") String username, @RequestParam("password") String password,
			User user,HttpServletRequest request) {

		/*
		 * System.out.println("提交的用户信息：" + user.getUsername() + user.getPassword() +
		 * user.getSex() + user.getPhoto() + user.getSignature());
		 */
		String regName = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		String regPassword = "^[a-zA-Z0-9_-]{5,18}$";
		if (!username.matches(regName)) {
			return Msg.fail().add("user_msg", "用户名必须为2-5位中文或者5-16位英文和数字，下划线，中划线的组合");
		}
		if (!password.matches(regPassword)) {
			return Msg.fail().add("pass_msg", "密码必须为6-18位字母数字下划线中划线的组合");
		}

		user.setUn(StringUtil.generateUn("U", ""));

		User existuser = userService.findByUserName(username);
		if (existuser != null) {
			return Msg.fail().add("user_msg", "用户名已存在");
		}
		if(userService.add(user)<=0) {
			return Msg.fail().add("user_msg", "添加用户失败");
		}
		
		Integer maleNum = userService.getNumBySex("男");
	    Integer femaleNum = userService.getNumBySex("女");
		request.getSession().setAttribute("maleNum", maleNum);
		request.getSession().setAttribute("femaleNum", femaleNum);
		
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
	  public Msg getUser(@PathVariable("id") Integer id) {
		 User user = userService.findById(id);
		 //System.out.println("根据id查询到的用户信息："+user);
		  return Msg.success().add("user",user);
	  }
	 
	 /**
	  * 编辑用户
	  * @param admin
	  * @return
	  */
	 @RequestMapping(value="/edit/{id}",method=RequestMethod.POST)
	 @ResponseBody 
	 public Msg edit( User  user,HttpServletRequest request,@PathVariable("id") Integer id) {
		 //System.out.println("将要更新的用户数据："+ user);
		userService.edit(user);
	
		if(	userService.edit(user)<0) {
			return Msg.fail();
		}
		
		System.out.println("编辑用户的id:"+id);
		Object userType =  request.getSession().getAttribute("userType"); 
		if("2".equals(userType.toString())) {
			//普通用户
			//User loginedUser = (User) request.getSession().getAttribute("user");
			//Long userId = loginedUser.getId();
			 User newUser = userService.findById(id);
			 request.getSession().setAttribute("user", newUser);
		}
		 return Msg.success();
	 }
	 
/**
      *     用户删除(单个，批量删除)
  * @param id
  * @return
  */
 @RequestMapping(value="/delete/{ids}",method=RequestMethod.POST)
 @ResponseBody 
 public Msg deleteById(@PathVariable("ids") String ids,HttpServletRequest request) {
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
		if(userService.deleteAll(idsString)<=0) {
			 return Msg.fail(); 
		}
	 }else {
		 Integer id = Integer.parseInt(ids);
		/* System.out.println("删除管理员" + id);  */
		 if(userService.deleteById(id)<=0) {
			 System.out.println("删除用户失败");
			  return Msg.fail(); 
		  }
	 }
	 Integer maleNum = userService.getNumBySex("男");
     Integer femaleNum = userService.getNumBySex("女");
     request.getSession().setAttribute("maleNum", maleNum);
	 request.getSession().setAttribute("femaleNum", femaleNum);
	 return Msg.success(); 
 }
 

	/**
	 * 上传用户头像图片 把上传的图片路径保存到数据库中
	 * 
	 * @param photo
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/upload_photo", method = RequestMethod.POST)
	@ResponseBody
	public Msg uploadPhoto(MultipartFile photo, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		//System.out.println("提交的图片文件：" + photo);
		if (photo == null) {
			// 文件没有选择
			//System.out.println(photo);
			return Msg.fail().add("errMsg", "请选择文件");
		}
		if (photo.getSize() > 10485760) {
			// 图片大小超过限制
			return Msg.fail().add("errMsg", "文件大小超过10M，请上传小于10M的图片！");
		}
		String suffix = photo.getOriginalFilename().substring(photo.getOriginalFilename().lastIndexOf(".") + 1,
				photo.getOriginalFilename().length());
		if (!"jpg,png,gif,jpeg".contains(suffix.toLowerCase())) {
			// 图片格式不正确
			/* System.out.println("图片格式不正确"); */
			return Msg.fail().add("errMsg", "文件格式不正确，请上传jpg,png,gif,jpeg格式的图片！");
		}
		String savePath = request.getServletContext().getRealPath("/") + "\\upload\\";
//		System.out.println("图片上传到的根路径"+request.getServletContext().getRealPath("/"));
//		System.out.println("图片保存的位置"+savePath);

		File savePathFile = new File(savePath);
		if (!savePathFile.exists()) {
			// 如果路径不存在，则创建一个文件夹
			savePathFile.mkdir();
		}
		// 把文件转存到这个文件夹下
		String filename = new Date().getTime() + "." + suffix;
		photo.transferTo(new File(savePath + filename));
		/*
		 * String path = request.getServletContext().getContextPath();
		 * System.out.println("获取到的上传的图片的路径："+path);
		 */
		// String hh = request.getServletContext().getContextPath() + "/upload/" +
		// filename);
		return Msg.success().add("successMsg", "文件上传成功").add("src",
				request.getServletContext().getContextPath() + "/upload/" + filename);

	}
}
