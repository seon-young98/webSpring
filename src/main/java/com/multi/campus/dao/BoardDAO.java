package com.multi.campus.dao;

import java.util.List;

import com.multi.campus.dto.BoardDTO;
import com.multi.campus.dto.PagingVO;

public interface BoardDAO {
	//총레코드수
	public int totalRecord(PagingVO vo);
	//해당 페이지 선택
	public List<BoardDTO> pageSelect(PagingVO vo);
	//여러개의 글 한번에 삭제
	public int boardMultiLineDelete(List<Integer> noList);
}
