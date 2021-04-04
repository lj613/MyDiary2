package com.diary.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.diary.entity.DiaryType;
import com.diary.entity.User;

@Repository
public interface DiaryTypeDao {
	
	public DiaryType findByTypeName(String typeName);
	
	public int add(DiaryType diaryType); 
	
	public int getTotalNum(); 
	
	public List<DiaryType> findList();
	
	public DiaryType findById(Integer diaryTypeId);

	public int edit(DiaryType diaryType); 
	public int deleteById(Integer diaryTypeId);
	public int deleteAll(String ids);
	
	 
}
