package com.multi.campus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.multi.campus.service.BoardService;

//Controller: 뷰단언어를 사용할 수 없다. 스크립트가 필요하면 jsp파일을 생성하여 구현한다.
//RestController: 프론트언어를 백엔드에서 기술할 수 있는 기능을 제공한다.
//              반환형을 String으로 하면 뷰페이지파일명이 아니라 컨텐츠 내용으로 처리한다.

@RestController
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardService service;
	
	//게시판 목록
	@GetMapping("/boardList")
	public ModelAndView boardList() {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("list", service.pageSelect());
		mav.setViewName("board/boardList");
		return mav;
	}
}
