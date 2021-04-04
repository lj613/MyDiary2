package com.diary.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.diary.dao.DiaryTypeDao;
import com.diary.entity.DiaryType;
import com.diary.service.DiaryTypeService;

@Service
public class DiaryTypeServiceImpl implements DiaryTypeService {

	@Autowired
	private DiaryTypeDao diaryTypeDao;
	
	// @Override
	public DiaryType findByTypeName(String typeName) {
		// TODO Auto-generated method stub
		return diaryTypeDao.findByTypeName(typeName);
	}

	public int add(DiaryType diaryType) {
		return diaryTypeDao.add(diaryType);
	}

	public List<DiaryType> findList() {

		List<DiaryType> diaryType = diaryTypeDao.findList();
		return diaryType;
	}

	public DiaryType findById(Integer diaryTypeId) {

		return diaryTypeDao.findById(diaryTypeId);
	}

	public int edit(DiaryType diaryType) {
		return diaryTypeDao.edit(diaryType);
	}

	public int deleteById(Integer diaryTypeId) {
		return diaryTypeDao.deleteById(diaryTypeId);
	}

	public int deleteAll(String ids) {
		return diaryTypeDao.deleteAll(ids);
	}
	
	public int getTotalNum() {
		return diaryTypeDao.getTotalNum();
	}

}
