package com.diary.entity;

import org.springframework.stereotype.Component;

/**
   * 管理员实体类
 * @author Lenovo
 *
 */
@Component
public class Admin {
       private Long id;//管理员id 主键 自增
       private String username;//用户名
       private String password; //密码
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String toString() {
		return "Admin[id="+ id +",username="+ username +",password="+password+ "]";
	}
       
}
