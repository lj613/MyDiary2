package com.diary.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.diary.dao.DiaryDao;
import com.diary.entity.Diary;
import com.diary.service.DiaryService;

@Service
public class DiaryServiceImpl implements DiaryService {

	@Resource
	private DiaryDao diaryDao;
	
	// @Override
	/*
	 * public DiaryType findByTypeName(String typeName) { // TODO Auto-generated
	 * method stub return diaryDao.findByTypeName(typeName); }
	 */

	//带参数查询日记列表
	/* public List<Diary> list(Map<String,Object> map); */
	
	//查询日记总数
	@Override
	public Long getTotalNum(Map<String,Object> map) {
		return diaryDao.getTotalNum(map);
	}

	//无参数查找所有日记
	@Override
	public List<Diary> findList() {
		return diaryDao.findList();
	}

	//带参数查询日记列表
	@Override
	public List <Diary> list(Map<String,Object> map) {
		return diaryDao.list(map);
	}
	
	//根据id查询日记
	@Override
	public Diary findById(Integer id) {
		return diaryDao.findById(id);
	}
	
	//添加日记
	@Override
	public int add(Diary diary) {
		return diaryDao.add(diary);
	}

	//修改日记
	@Override
	public int edit(Diary diary) {
		return diaryDao.edit(diary);
	}

	//根据id单个删除日记
	@Override
	public int deleteById(Integer id) {
		return diaryDao.deleteById(id);
	}

	//批量删除日记
	@Override
	public int deleteAll(String ids) {
		return diaryDao.deleteAll(ids);
	}
	
	
}
