package com.diary.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.diary.entity.DiaryType;
import com.diary.entity.User;

@Service
public interface DiaryTypeService {
	public DiaryType findByTypeName(String typeName);
	
    public int add(DiaryType diaryType); 
	
	public List<DiaryType> findList();
	
	public DiaryType findById(Integer diaryTypeId);

	public int edit(DiaryType diaryType); 
	
	public int deleteById(Integer diaryTypeId);
	
	public int deleteAll(String ids);
	
	public int getTotalNum(); 
}
