package com.multi.campus.service;

import java.util.List;

import com.multi.campus.dto.BoardDTO;
import com.multi.campus.dto.PagingVO;

public interface BoardService {
	public int totalRecord(PagingVO vo);
	public List<BoardDTO> pageSelect(PagingVO vo);
	public int boardMultiLineDelete(List<Integer> noList);
}
