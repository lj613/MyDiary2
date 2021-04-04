package com.diary.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.diary.entity.Diary;
import com.diary.entity.DiaryType;

@Repository
public interface DiaryDao {
	/*
	 * public DiaryType findByTypeName(String typeName);
	 */
	
	//无参数查找所有日记
	public List<Diary> findList();
	
	//带参数查询日记列表
	public List<Diary> list(Map<String,Object> map);
	
	//带参数查询日记数量
	public Long getTotalNum(Map<String,Object> map); 
	
	
	
	//根据id查询日记
	public Diary findById(Integer id);

	//添加日记
	public int add(Diary diary); 
	
	//修改日记
	public int edit(Diary diary); 
	
	//根据id单个删除日记
	public int deleteById(Integer id);
	
	//批量删除日记
	public int deleteAll(String ids);
	
	 
}
