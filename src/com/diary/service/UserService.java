package com.diary.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.diary.entity.User;

@Service
public interface UserService {
	  public User findByUserName(String username);

	  public int add(User user);
	  
	  public List<User> findList();
	  //模糊查询
	  public List<User> searchBywords(String keywords);
	 
	  public User findById(Integer id);
	  

	  public int edit(User user);
	  public int deleteById(Integer id);
	  
	  public int deleteAll(String ids);
	  public int getNumBySex(String sex);
	  
}
