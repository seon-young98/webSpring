package com.multi.campus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.multi.campus.dto.BoardDTO;
import com.multi.campus.dto.PagingVO;
import com.multi.campus.service.BoardService;

//Controller: 뷰단언어를 사용할 수 없다. 스크립트가 필요하면 jsp파일을 생성하여 구현한다.
//RestController: 프론트언어를 백엔드에서 기술할 수 있는 기능을 제공한다.
//              반환형을 String으로 하면 뷰페이지파일명이 아니라 컨텐츠 내용으로 처리한다.

@RestController
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardService service;
	
	//게시판목록
	@GetMapping("/boardList") // /board/boardList
	public ModelAndView boardList(PagingVO vo) {
		
		ModelAndView mav = new ModelAndView();
		
		//총레코드 수를 구하여
		vo.setTotalRecord(service.totalRecord(vo));
		System.out.println(vo.toString());
		
		//DB조회
		//해당 페이지 레코드 선택하기
		mav.addObject("list", service.pageSelect(vo));
			
		mav.addObject("vo", vo); //뷰페이지로 페이지정보 세팅
		mav.setViewName("board/boardList");
		return mav;
	}
	
	//여러 개의 글 한번에 삭제하기
		@PostMapping("/boardMultiDel")
		public ModelAndView boardMultiDel(BoardDTO dto, PagingVO vo) {
			
			int result = service.boardMultiLineDelete(dto.getNoList());
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("nowPage", vo.getNowPage());
			if(vo.getSearchWord()!=null && !vo.getSearchWord().equals("")) {
				mav.addObject("searchKey", vo.getSearchKey());
				mav.addObject("searchWord", vo.getSearchWord());
			}
			mav.setViewName("redirect:boardList");
			return mav;
		}
}