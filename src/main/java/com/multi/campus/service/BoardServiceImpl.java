package com.multi.campus.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.campus.dao.BoardDAO;
import com.multi.campus.dto.BoardDTO;
import com.multi.campus.dto.PagingVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	BoardDAO dao;

	@Override
	public int totalRecord(PagingVO vo) {
		return dao.totalRecord(vo);
	}

	@Override
	public List<BoardDTO> pageSelect(PagingVO vo) {
		return dao.pageSelect(vo);
	}

	@Override
	public int boardMultiLineDelete(List<Integer> noList) {
		return dao.boardMultiLineDelete(noList);
	}
	
	
}


