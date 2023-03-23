package com.multi.campus.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.multi.campus.dto.RegisterDTO;
import com.multi.campus.service.RegisterService;

@Controller
public class RegisterController {
	@Autowired
	RegisterService service;
	
	@GetMapping("/loginForm")
	public String login() {
		return "register/loginForm"; // /WEB-INF/views/register/loginForm.jsp
	}
	
	//로그인(DB)
	@PostMapping("/loginOk")
	public ModelAndView loginOk(String userid, String userpwd, HttpServletRequest request, HttpSession session) {
		//Session 객체 얻어오기
		//매개변수로 HttpServletRequest request -> Session구하기
		//매개변수로 HttpSession session
		
		RegisterDTO dto = service.loginOk(userid, userpwd);
		
		//dto가 null이면 선택 레코드가 없다. -> 로그인 실패
		//dto가 null이 아니면 선택 레코드가 있다. -> 로그인 성공
		
		ModelAndView mav = new ModelAndView();
		
		if(dto!=null) { //로그인성공
			session.setAttribute("logId", dto.getUserid());
			session.setAttribute("logName", dto.getUsername());
			session.setAttribute("logStatus", "Y");
			mav.setViewName("redirect:/"); //홈으로 이동
		}else { //로그인실패
			mav.setViewName("redirect:loginForm"); //로그인페이지로 이동
		}
		return mav;
	}
	
	//로그아웃 - 세션제거
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate(); //설정된 세션의 값들을 모두 사라지게 한다.
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	//회원가입폼
	@GetMapping("/join")
	public String join() {
		return "register/join";
	}
	
	
}
