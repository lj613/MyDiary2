package com.diary.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.diary.entity.DiaryType;
import com.diary.service.DiaryTypeService;
import com.diary.util.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.sf.json.JSONArray;

/**
 * 日记类型控制器
 * 
 * @author Lenovo
 *
 */
@RequestMapping("/diaryType")
@Controller
public class DiaryTypeController {

	@Autowired
	private DiaryTypeService diaryTypeService;
	

	/**
	 * 日记类型列表页
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list(ModelAndView model) {
		model.setViewName("diaryType/diary_type_list");
		return model;
	}

	/**
	 * 获取日记类型列表
	 * 
	 * @param pn
	 * @param model
	 * @return
	 */
	@RequestMapping("/get_list")
	@ResponseBody
	// @ResponseBody自动把返回的对象转换为json字符串 @ResponseBody使用需要jackson包
	public Msg getDiaryTypesWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model,
			HttpServletRequest request) {

		//System.out.println("调用日记类型列表获取方法hhhhhhhhhhhhhhhhhh");
		// 使用分页插件 传入页码和每页的大小
		PageHelper.startPage(pn, 10);
		//查询所有日记类型
		List<DiaryType> diaryTypeList = diaryTypeService.findList();
		JSONArray  diaryTypeList2 = JSONArray.fromObject(diaryTypeList);
		//保存到session中
		request.getSession().setAttribute("diaryTypeList2", diaryTypeList2);
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面 传入连续显示的页数5
		PageInfo pageInfo = new PageInfo(diaryTypeList, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}

	

	/**
	 * 添加日记类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public Msg addDiaryType(@RequestParam("typeName") String typeName, DiaryType diarytype,HttpServletRequest request) {

		System.out.println("提交的日记类别名称：" + typeName);
		System.out.println("提交的日记类别：" + diarytype);
		DiaryType existDiaryType = diaryTypeService.findByTypeName(typeName); 
		System.out.println("已存在"+existDiaryType);
		if (existDiaryType != null) {
			return Msg.fail().add("error_msg", "此日记类型已存在");
		}
		
		if(diaryTypeService.add(diarytype)<=0) {
			return Msg.fail();
		}
		Integer diaryTypeNum = diaryTypeService.getTotalNum();
		request.getSession().setAttribute("diaryTypeNum", diaryTypeNum);
		//查询所有日记类型
		List<DiaryType> diaryTypeList = diaryTypeService.findList();
		JSONArray  diaryTypeList2 = JSONArray.fromObject(diaryTypeList);
		//保存到session中
	    request.getSession().setAttribute("diaryTypeList2", diaryTypeList2);
		return Msg.success();
	}

	/**
	 * 根据日记类型id查询日记类型
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	// 从路径中获取id
	public Msg getDiaryType(@PathVariable("id") Integer id) {
		DiaryType diaryType = diaryTypeService.findById(id);
		System.out.println("根据id查询到的日记类别信息：" + diaryType);
		return Msg.success().add("diaryType", diaryType);
	}

	/**
	 * 编辑日记类别
	 * 
	 * @param admin
	 * @return
	 */
	@RequestMapping(value = "/edit/{diaryTypeId}", method = RequestMethod.POST)
	@ResponseBody
	public Msg edit(DiaryType diaryType) {
		System.out.println("将要更新的日记类别数据：" + diaryType);
		diaryTypeService.edit(diaryType);
		if(diaryTypeService.edit(diaryType)<=0) {
			return Msg.fail();
		}
		return Msg.success();
	}

	/**
	 * 日记类别删除(单个，批量删除)
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
	@ResponseBody
	public Msg deleteById(@PathVariable("ids") String ids,HttpServletRequest request) {
		System.out.println("选中的所有id:" + ids);
		if (ids.contains("-")) {
			// 批量删除
			String idsString = "";
			String[] str_ids = ids.split("-");

			for (String string : str_ids) {
				idsString += string + ",";
			}
			// 去除最后一个逗号
			idsString = idsString.substring(0, idsString.length() - 1);
			System.out.println("重新组装好的id字符串：" + idsString);
			if (diaryTypeService.deleteAll(idsString) <= 0) {
				return Msg.fail();
			}
		} else {
			Integer id = Integer.parseInt(ids);
			/* System.out.println("删除日记类别" + id); */
			if (diaryTypeService.deleteById(id) <= 0) {
				System.out.println("删除日记类别失败");
				return Msg.fail();
			}
		}
		Integer diaryTypeNum = diaryTypeService.getTotalNum();
		request.getSession().setAttribute("diaryTypeNum", diaryTypeNum);
		//查询所有日记类型
		List<DiaryType> diaryTypeList = diaryTypeService.findList();
		JSONArray  diaryTypeList2 = JSONArray.fromObject(diaryTypeList);
		//保存到session中
	    request.getSession().setAttribute("diaryTypeList2", diaryTypeList2);
		return Msg.success();
	}

}
