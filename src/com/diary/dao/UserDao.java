package com.diary.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.diary.entity.User;

@Repository
public interface UserDao {
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
