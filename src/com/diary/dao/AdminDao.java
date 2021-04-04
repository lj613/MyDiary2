package com.diary.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.diary.entity.Admin;

@Repository
public interface AdminDao {
	public Admin findByUserName(String username);
	
	public int add(Admin user); 
	public List<Admin> findList();
	//模糊查询
	public List<Admin> searchBywords(String keywords);
	public Admin findById(Integer id);
//	public List<User> findList(Map<String,Object> queryMap);
	public int edit(Admin admin); 
	public int deleteById(Integer id);
	public int deleteAll(String ids);
	 
}
