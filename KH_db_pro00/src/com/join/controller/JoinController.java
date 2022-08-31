package com.join.controller;

import com.join.dao.JoinDAO;
import com.join.vo.JoinVO;
 
/*
 * 회원 가입 처리를 위한 중간 제어용 객체로 활용
 */
public class JoinController {
	
	private JoinDAO dao = new JoinDAO();

	public boolean join(JoinVO data) {
		switch(data.getGender()) {
			case '남':
				data.setGender('M');	break;
			case '여':
				data.setGender('F');	break;
			default:
				return false;
		}

		if(data.getAge() < 15) {
			return false;
		}
		
		JoinVO account = dao.get(data.getUserid());
		
		if(account != null) {
			return false;
		}

		boolean result = dao.register(data);
		return result;
	}
	
	public boolean update(JoinVO data) {
		return dao.update(data);
	}
	
	public boolean remove(JoinVO data) {
		return dao.remove(data);
	}

	public JoinVO login(String userid, String userpw) {
		JoinVO data = dao.get(userid);
		
		if(data.getUserpw().equals(userpw)) {
			return data;
		}
		
		return null;
	}

}