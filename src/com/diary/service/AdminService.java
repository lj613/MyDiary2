package com.diary.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


import com.diary.entity.Admin;

@Service
public interface AdminService {
	public Admin findByUserName(String username);

	
	  public int add(Admin admin);
	  public List<Admin> findList();
	  //模糊查询
	  public List<Admin> searchBywords(String keywords);
	 
	  public Admin findById(Integer id);
	  
      //public List<User> findList(Map<String, Object> queryMap);
	  public int edit(Admin admin);
	  public int deleteById(Integer id);
	  
	  public int deleteAll(String ids);
	  
}
