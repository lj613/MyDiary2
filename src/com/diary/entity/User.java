package com.diary.entity;

import org.springframework.stereotype.Component;

/**
   *     用户实体类
 * @author Lenovo
 *
 */
@Component
public class User {
	
	private Long id;
	private String un;//用户编号
	private String username;
	private String password;
	private String sex;
	private String photo;//头像
	private String signature;//个性签名
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
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getUn() {
		return un;
	}
	public void setUn(String un) {
		this.un = un;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String toString() {
		return "User[id="+ id +",un="+ un +",username="+ username +",photo="+ photo +",password="+password+ ",sex="+ sex +",signature="+ signature +"]";
	}
	
}
