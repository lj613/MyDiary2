package com.diary.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.diary.dao.UserDao;
import com.diary.entity.User;
import com.diary.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	// @Override
	public User findByUserName(String username) {
		// TODO Auto-generated method stub
		return userDao.findByUserName(username);
	}
	
	// @Override
	public int add(User user) {
		// TODO Auto-generated method stub 
		return userDao.add(user);
	} 
	
	public List<User> findList(){

		List<User> user = userDao.findList();
		return user;
	}
	public List<User> searchBywords(String keywords){
		List<User> user = userDao.searchBywords(keywords);
		return user;
	};
	public User findById(Integer id) {
		
		return userDao.findById(id);
	}
	
	// @Override
	public int edit(User user){ 
	  // TODO Auto-generated method stub
	     return userDao.edit(user);
	  }
	  
	  public int  deleteById(Integer id){
		  return userDao.deleteById(id);
	  }
	 
	  public int deleteAll(String ids){
		  return userDao.deleteAll(ids);
	  }
	  
	  public int getNumBySex(String sex) {
		  return userDao.getNumBySex(sex);
	  }
}
