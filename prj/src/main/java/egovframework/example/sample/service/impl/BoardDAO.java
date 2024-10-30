package egovframework.example.sample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.service.BoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


@Repository("boardDAO")
public class BoardDAO extends EgovAbstractDAO {

	public String InsertBoard(BoardVO vo){
		return (String) insert("boardDAO.InsertBoard", vo);
	}


	
	 public List<?> SelectBoardList(BoardVO vo) { 
		 return (List<?>) list("boardDAO.SelectBoardList", vo);
	 }



	public BoardVO selectBoardDetail(int idx) {
		
		
		return (BoardVO) select("boardDAO.selectBoardDetail",idx );
	}
	 

	public int boardDelete(int idx) {
		return (int)delete("boardDAO.boardDelete", idx);
	}



	public int updateBoard(BoardVO vo) {
		return update("boardDAO.updateBoard",vo);
	}



	public int selectTBBoardTotal(BoardVO vo) {
		return (int)select("boardDAO.selectTBBoardTotal",vo);
	}



	public int updateBoardViewcount(int idx) {
		return update("boardDAO.updateBoardViewcount", idx);
	}



	public int selectBoardPass(BoardVO vo) {
		
		return  (int)select("boardDAO.selectBoardPass", vo);
	}



	public Object deleteFile(BoardVO vo) {
		return update("boardDAO.deleteFile", vo);
	}	
	
	public Object deleteFileName(BoardVO vo) {
		return delete("boardDAO.deleteFileName", vo);
	}	
	
	
}
