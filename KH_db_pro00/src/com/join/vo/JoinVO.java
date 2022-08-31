package com.join.vo;

import java.sql.Date;
 
/*
 * 회원 가입을 위한 사용자 정보를 담고 있는 객체로 활용
 * 멤버 변수에 대한 getter/setter 필요.
 */
public class JoinVO {
	private String userid;		// 아이디				20 Byte
	private String userpw;		// 패스워드				20 Byte
	private String username;	// 사용자의 실제 이름	20 Byte
	private char gender;		// M:남자, F:여자		1  Byte
	private int age;			// 나이
	private Date createDate;	// 회원가입일
	
	public String getUserid() {
		return userid;
	}
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getUserpw() {
		return userpw;
	}
	
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public char getGender() {
		return gender;
	}
	
	public void setGender(char gender) {
		this.gender = gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender.charAt(0);
	}
	
	public int getAge() {
		return age;
	}
	
	public void setAge(int age) {
		this.age = age;
	}
	
	public void setAge(String age) {
		this.age = Integer.parseInt(age);
	}
	
	public Date getCreateDate() {
		return createDate;
	}
	
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
}