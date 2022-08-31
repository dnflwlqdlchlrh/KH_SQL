package com.join.menu;

public class Menu {
	
	public String getMain() {
		String s = "";
		s += "<<< 회원가입 프로그램 >>>\n";
		s += "┌───────────────────────┐\n";
		s += "│ 1. 회원 가입          │\n";
		s += "│ 2. 로그인             │\n";
		s += "│ 3. 프로그램 종료      │\n";
		s += "└───────────────────────┘\n";
		
		return s;
	}
	 
	public String getAfterLogin(String username) {
		String s = "";
		s += "<<< " + username + "님 환영 합니다. >>>\n";
		s += "┌───────────────────────┐\n";
		s += "│ 1. 정보 확인          │\n";
		s += "│ 2. 정보 수정          │\n";
		s += "│ 3. 회원 탈퇴          │\n";
		s += "│ 4. 로그 아웃          │\n";
		s += "└───────────────────────┘\n"; 
		
		return s;
	}
	
}