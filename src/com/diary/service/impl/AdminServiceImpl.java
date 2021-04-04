package com.diary.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.diary.dao.AdminDao;
import com.diary.entity.Admin;
import com.diary.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;

	// @Override
	public Admin findByUserName(String username) {
		// TODO Auto-generated method stub
		return adminDao.findByUserName(username);
	}
	
	// @Override
	public int add(Admin admin) {
		// TODO Auto-generated method stub 
		return adminDao.add(admin);
	} 
	
	public List<Admin> findList(){
//		return userDao.findList();
		List<Admin> admin = adminDao.findList();
		return admin;
	}
	public List<Admin> searchBywords(String keywords){
		List<Admin> admin = adminDao.searchBywords(keywords);
		return admin;
	};
	public Admin findById(Integer id) {
		
		return adminDao.findById(id);
	}
	
	/*
	 * // @Override public List<User> findList(Map<String,Object> queryMap) { //
	 * TODO Auto-generated method stub return userDao.findList(queryMap); }
	 */
	  
	/*
	 * // @Override public int getTotal(Map<String, Object> queryMap) { // TODO
	 * Auto-generated method stub return userDao.getTotal(queryMap); }
	 */
	  
	  
	
	  // @Override
	  public int edit(Admin admin){ 
		  // TODO Auto-generated method stub
	     return adminDao.edit(admin);
	  }
	  
	  public int  deleteById(Integer id){
		  return adminDao.deleteById(id);
	  }
	 
	  public int deleteAll(String ids){
		  return adminDao.deleteAll(ids);
	  }
	  
	
	  
	/*
	 * //@Override public int delete(String ids) { // TODO Auto-generated method
	 * stub return userDao.delete(ids); }
	 */
	 
}
