package com.diary.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.diary.entity.Admin;
import com.diary.entity.Diary;
import com.diary.entity.DiaryType;
import com.diary.entity.User;
import com.diary.service.DiaryService;
import com.diary.service.DiaryTypeService;
import com.diary.service.UserService;
import com.diary.util.Msg;
import com.diary.util.StringUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@RequestMapping("/diary")
@Controller
public class DiaryController {

	@Resource
	private DiaryService diaryService;
	@Resource
	private UserService userService;
	@Resource
	private DiaryTypeService diaryTypeService;

	/**
	 * 写日记页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/w_diary", method = RequestMethod.GET)

	public ModelAndView list(ModelAndView model) {
		model.setViewName("diary/w_diary");
		return model;
	}

	/**
	 * 日记列表页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)

	public ModelAndView get_list(ModelAndView model) {
		model.setViewName("diary/diary_list");
		return model;
	}

	/**
	 * 修改日记页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/modify", method = RequestMethod.GET)

	public ModelAndView modify(ModelAndView model) {
		model.setViewName("diary/modify_diary");
		return model;
	}

	/**
	 * 日记详情页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	// @RequestMapping(value = "/detail", method = RequestMethod.GET)

	public ModelAndView detail(ModelAndView model) {
		model.setViewName("diary/diary_detail");
		return model;
	}

	/**
	 * 获取日记列表
	 * 
	 * @param pn
	 * @param diary
	 * @param request
	 * @return
	 */
	@RequestMapping("/get_list")
	@ResponseBody
	// @ResponseBody自动把返回的对象转换为json字符串 @ResponseBody使用需要jackson包
	public Msg getDiaryTypesWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			HttpServletRequest request) {
		int userType = (int) request.getSession().getAttribute("userType");
		// System.out.println("调用日记列表获取方法");
		// 使用分页插件 传入页码和每页的大小

		PageHelper.startPage(pn, 10);
		Map<String, Object> map = new HashMap();
		List<Diary> diaryList = new ArrayList();

		// map.put("title", StringUtil.formatLike(diary.getTitle()));
		if (userType == 2) {
			User loginedUser = (User) request.getSession().getAttribute("user");
			Long userId = loginedUser.getId();
			map.put("userId", userId);
			// List<Diary> diaryList = diaryService.list(map);
			diaryList = diaryService.list(map);
		} else if (userType == 1) {
			diaryList = diaryService.list(map);
		}

		// List<Diary> diaryList = diaryService.findList();
		// System.out.println("查询到的日记列表"+diaryList);
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面
		// 传入连续显示的页数5
		PageInfo pageInfo = new PageInfo(diaryList, 5);

		return Msg.success().add("pageInfo", pageInfo);

	}

	/**
	 * 按标题查询日记
	 * 
	 * @param pn
	 * @param model
	 * @param keywords
	 * @return
	 */
	@RequestMapping(value = "/search/{keywords}", method = RequestMethod.GET)
	@ResponseBody
	public Msg adminSearch(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model,
			HttpServletRequest request, @PathVariable("keywords") String keywords) {
		// System.out.println("调用搜索方法keywords为：" + keywords);
		// System.out.println(keywords);
		int userType = (int) request.getSession().getAttribute("userType");
		// 使用分页插件 传入页码和每页的大小
		PageHelper.startPage(pn, 10);
		// 模糊查询
		Map<String, Object> map = new HashMap();

		// map.put("title", StringUtil.formatLike(diary.getTitle()));
		if (userType == 2) {
			User loginedUser = (User) request.getSession().getAttribute("user");
			Long userId = loginedUser.getId();
			map.put("userId", userId);
			map.put("title", StringUtil.formatLike(keywords));
		} else if (userType == 1) {
			map.put("title", StringUtil.formatLike(keywords));
		}
//		User loginedUser = (User) request.getSession().getAttribute("user");
//		Long userId = loginedUser.getId();
//		map.put("userId",userId);
//		map.put("title", StringUtil.formatLike(keywords));
		List<Diary> diaryList = diaryService.list(map);

		// List<Admin> adminList = adminService.searchBywords(keywords);
		/* System.out.println("模糊查询的结果：" + adminList); */
		PageInfo pageInfo = new PageInfo(diaryList, 10);
		return Msg.success().add("pageInfo", pageInfo);
	}

	/**
	 * 按日期查询日记
	 * 
	 * @param pn
	 * @param model
	 * @param keywords
	 * @return
	 */
	@RequestMapping(value = "/search2/{releaseDate}", method = RequestMethod.GET)
	@ResponseBody
	public Msg diarySearch(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model,
			HttpServletRequest request, @PathVariable("releaseDate") String releaseDate) {
		System.out.println("调用按日期搜索方法keywords为：" + releaseDate);
		int userType = (int) request.getSession().getAttribute("userType");
		// System.out.println(keywords);
		// 使用分页插件 传入页码和每页的大小
		PageHelper.startPage(pn, 10);
		// 模糊查询
		Map<String, Object> map = new HashMap();

		// map.put("title", StringUtil.formatLike(diary.getTitle()));
		if (userType == 2) {
			User loginedUser = (User) request.getSession().getAttribute("user");
			Long userId = loginedUser.getId();
			map.put("userId", userId);
			map.put("releaseDateStr", releaseDate);
		} else if (userType == 1) {
//    	   User loginedUser = (User) request.getSession().getAttribute("user");
//   		Long userId = loginedUser.getId();
//   		map.put("userId",userId);
			map.put("releaseDateStr", releaseDate);
		}

		List<Diary> diaryList = diaryService.list(map);

		// List<Admin> adminList = adminService.searchBywords(keywords);
		System.out.println("模糊查询的结果：" + diaryList);
		PageInfo pageInfo = new PageInfo(diaryList, 10);
		return Msg.success().add("pageInfo", pageInfo);
	}

	/**
	 * 添加日记
	 * 
	 * @param diary
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public Msg addDiary(Diary diary, HttpServletRequest request) {

		User loginedUser = (User) request.getSession().getAttribute("user");
		Long userId = loginedUser.getId();
		/*
		 * System.out.print("登陆的用户id:" + userId); System.out.println("调用日记保存方法");
		 * System.out.println(diary); System.out.println(diary.getTitle());
		 * System.out.println(diary.getContent());
		 */
		diary.setUser(loginedUser);
		if (diaryService.add(diary) <= 0) {
			return Msg.fail();
		}
		Map<String, Object> map = new HashMap();
		// 所有用户日记总数
		Long diaryTotalNum = diaryService.getTotalNum(map);
		map.put("userId", userId);
		// 当前登陆用户所写的日记总数
		Long diaryNum = diaryService.getTotalNum(map);
		request.getSession().setAttribute("diaryTotalNum", diaryTotalNum);
		request.getSession().setAttribute("diaryNum", diaryNum);
		// 重新统计并保存各日记类别的数量
		staticDiaryTypeNum(userId, request);
		return Msg.success();
	}

	/**
	 * 编辑日记
	 * 
	 * @param admin
	 * @return
	 */
	@RequestMapping(value = "/modify/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Msg edit(Diary diary) {
		// System.out.println("将要更新的日记数据："+ diary);
		diaryService.edit(diary);
		return Msg.success();
	}

	/**
	 * 根据日记id查询日记信息
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	// 从路径中获取id
	public Msg getDiary(@PathVariable("id") Integer id) {
		// System.out.println(id);
		Diary diary = diaryService.findById(id);
		// System.out.println("根据id查询到的日记信息："+diary);
		return Msg.success().add("diary", diary);
	}

	/**
	 * 日记删除(单个，批量删除)
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
	@ResponseBody
	public Msg deleteById(@PathVariable("ids") String ids, HttpServletRequest request) {
		// 获取登陆用户的类型
		int userType = (int) request.getSession().getAttribute("userType");
		// System.out.println("选中的所有id:"+ ids);
		if (ids.contains("-")) {
			// 批量删除
			String idsString = "";
			String[] str_ids = ids.split("-");

			for (String string : str_ids) {
				idsString += string + ",";
			}
			// 去除最后一个逗号
			idsString = idsString.substring(0, idsString.length() - 1);
			// System.out.println("重新组装好的id字符串：" + idsString);
			if (diaryService.deleteAll(idsString) <= 0) {
				return Msg.fail();
			}
		} else {
			Integer id = Integer.parseInt(ids);
			/* System.out.println("删除管理员" + id); */
			if (diaryService.deleteById(id) <= 0) {
				System.out.println("删除日记失败");
				return Msg.fail();
			}
		}

		Map<String, Object> map = new HashMap();
		if (userType == 2) {
			// 登陆用户为普通用户
			User loginedUser = (User) request.getSession().getAttribute("user");
			Long userId = loginedUser.getId();
			map.put("userId", userId);
			// 当前登陆用户所写的日记总数
			Long diaryNum = diaryService.getTotalNum(map);
			request.getSession().setAttribute("diaryNum", diaryNum);
			// 重新统计各日记类别的数量
			staticDiaryTypeNum(userId, request);
		} else if (userType == 1) {
			// 登陆用户为管理员
			// 所有用户日记总数
			Long diaryTotalNum = diaryService.getTotalNum(map);
			request.getSession().setAttribute("diaryTotalNum", diaryTotalNum);
		}
		return Msg.success();
	}

	/**
	 * 
	 * 统计各日记类别数量
	 */

	public void staticDiaryTypeNum(Long userId, HttpServletRequest request) {
		List<DiaryType> diaryTypeList = diaryTypeService.findList();
		System.out.println("日记类别列表：" + diaryTypeList);
		Map<String, Object> DiaryTypeMap = new HashMap();
		List<Object> diaryTypeData = new ArrayList<Object>();

		for (int i = 0; i < diaryTypeList.size(); i++) {
			JSONObject DataNode = new JSONObject();
			// 获取日记类别id
			Long diaryTypeId = diaryTypeList.get(i).getDiaryTypeId();
			// 获取日记类别名称
			String typeName = diaryTypeList.get(i).getTypeName();
			DiaryTypeMap.put("userId", userId);
			DiaryTypeMap.put("typeId", diaryTypeId);
			// 查询对应类别日记的数量
			Long diaryNum = diaryService.getTotalNum(DiaryTypeMap);
			DataNode.put("value", diaryNum);
			DataNode.put("name", typeName);
			// System.out.println(DataNode);
			// 将创建的对象添加到结果数组中
			diaryTypeData.add(DataNode);

		}
		// System.out.println(diaryTypeData);
		// 将日记各类别对应的数量保存在session中
		request.getSession().setAttribute("diaryTypeData", diaryTypeData);

		/*
		 * Map<String, Object> DiaryTypeMap1 = new HashMap();
		 * DiaryTypeMap1.put("userId",userId); DiaryTypeMap1.put("typeId",1); Long
		 * diarytype1Num = diaryService.getTotalNum(DiaryTypeMap1);
		 * 
		 * Map<String, Object> DiaryTypeMap2 = new HashMap();
		 * DiaryTypeMap2.put("userId",userId); DiaryTypeMap2.put("typeId",2); Long
		 * diarytype2Num = diaryService.getTotalNum(DiaryTypeMap2);
		 * 
		 * Map<String, Object> DiaryTypeMap3 = new HashMap();
		 * DiaryTypeMap3.put("userId",userId); DiaryTypeMap3.put("typeId",3); Long
		 * diarytype3Num = diaryService.getTotalNum(DiaryTypeMap3);
		 * 
		 * Map<String, Object> DiaryTypeMap4 = new HashMap();
		 * DiaryTypeMap4.put("userId",userId); DiaryTypeMap4.put("typeId",4); Long
		 * diarytype4Num = diaryService.getTotalNum(DiaryTypeMap4);
		 * 
		 * request.getSession().setAttribute("diarytype1Num", diarytype1Num);
		 * request.getSession().setAttribute("diarytype2Num", diarytype2Num);
		 * request.getSession().setAttribute("diarytype3Num", diarytype3Num);
		 * request.getSession().setAttribute("diarytype4Num", diarytype4Num);
		 */
	}

}
