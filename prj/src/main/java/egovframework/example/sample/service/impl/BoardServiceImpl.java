package egovframework.example.sample.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.BoardVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService{

	@Resource(name="boardDAO")
	private BoardDAO boardDAO;
	
	@Override
	public String InsertBoard(BoardVO vo) throws Exception {
		
		return boardDAO.InsertBoard(vo);
	}

	 @Override
	 public List<?> SelectBoardList(BoardVO vo) throws Exception {
		 
		 return boardDAO.SelectBoardList(vo); 
	 
	 }

	@Override
	public BoardVO selectBoardDetail(int idx) throws Exception {
		
		return boardDAO.selectBoardDetail(idx);
	}

	@Override
	public int boardDelete(int idx) throws Exception {
		
		return boardDAO.boardDelete(idx);
	}

	@Override
	public int updateBoard(BoardVO vo) throws Exception {
		
		return boardDAO.updateBoard(vo);
	}

	@Override
	public int selectTBBoardTotal(BoardVO vo) throws Exception {
		return boardDAO.selectTBBoardTotal(vo);
	}
	 
	@Override
	public int updateBoardViewcount(int idx) throws Exception {
		
		 return boardDAO.updateBoardViewcount(idx);
	}
	
	public int selectBoardPass(BoardVO vo) throws Exception{
		
		return boardDAO.selectBoardPass(vo);
	}

	@Override
	public void deleteFile(BoardVO vo) throws Exception {
		boardDAO.deleteFile(vo);
	}

	
	@Override
	public void deleteFileName(BoardVO vo) throws Exception {
		boardDAO.deleteFileName(vo);
	}
	
	

}
