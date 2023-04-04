package com.multi.campus.dao;

import java.util.List;

import com.multi.campus.dto.BoardDTO;

public interface BoardDAO {
	//글목록
	public List<BoardDTO> pageSelect();
}
