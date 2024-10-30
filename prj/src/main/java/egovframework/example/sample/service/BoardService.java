package egovframework.example.sample.service;

import java.util.List;

public interface BoardService {
	public String InsertBoard(BoardVO vo) throws Exception;

	public List<?> SelectBoardList(BoardVO vo) throws Exception;
	
	public BoardVO selectBoardDetail(int idx) throws Exception;
	
	public int boardDelete(int idx) throws Exception;
	
	public int updateBoard(BoardVO vo) throws Exception;
	
	public int selectTBBoardTotal(BoardVO vo) throws Exception;
	
	public int updateBoardViewcount(int idx) throws Exception;
	
	public int selectBoardPass(BoardVO vo) throws Exception;
	
	public void deleteFile(BoardVO vo) throws Exception;
	
	
	public void deleteFileName(BoardVO vo) throws Exception;
}
