package egovframework.example.sample.web;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.service.FileDetail;

@Controller
public class BoardController {
	
	@Resource(name="boardService")
	private BoardService boardService;
	

	@RequestMapping(value = "/boardWrite.do")
	public String boardWrite() {
			
	return "board/boardWrite";
	}
	
	@RequestMapping(value="/board/boardWriteSave.do")
	@ResponseBody
	public String boardWriteSave(@RequestParam(value = "file", required = false) MultipartFile[] boFiles, BoardVO vo, MultipartHttpServletRequest req, ModelMap model) throws Exception {

	    List<String> uploadFilePaths = new ArrayList<>();
	    List<String> fileNames = new ArrayList<>();

	    try {
	        if (boFiles != null ) {
	            for (MultipartFile multipart : boFiles) {
	                if (!multipart.isEmpty()) {
	                    String originalFileName = multipart.getOriginalFilename();
	                    String fileName = UUID.randomUUID().toString() + "_" + originalFileName; // 랜덤 파일 이름
	                    String uploadFile = "C:\\tools\\eGovFrameDev-3.10.0-64bit\\eclipse-workspace\\prj\\src\\main\\webapp\\uploadFiles\\" + fileName ; // 저장할 경로

	                    // 파일 저장
	                    FileUtils.copyInputStreamToFile(multipart.getInputStream(), new File(uploadFile));

	                    
	                 // 파일 경로와 이름을 리스트에 추가
	                    uploadFilePaths.add(uploadFile);
	                    fileNames.add(originalFileName);
	                    System.out.println("Uploaded file: " + uploadFile + " saved to: " + originalFileName);
	                }
	            }
	        }

	        // 구분자로 문자열 변환 (예: ",")
	    String uploadFilePathsString = String.join(",", uploadFilePaths);
	    String fileNamesString = String.join(",", fileNames);
        
	    // VO에 설정
	    vo.setUploadFile(uploadFilePathsString); // 문자열로 설정
	    vo.setFileName(fileNamesString); // 문자열로 설정 
        
	    // 게시글 등록
	    boardService.InsertBoard(vo);
        
	    return "ok"; // 성공 응답
	    } catch (Exception e) {
	    	e.printStackTrace(); // 오류 출력
	    return "error"; // 실패 응답
	    }
	}	
	 
	 @RequestMapping(value="/board/boardList.do") 
	 public String selectBoardList(BoardVO vo, ModelMap model) throws Exception{
	 

		 int unit = 10; // 한페이지에 보여줄 데이터 개수
		 int total = boardService.selectTBBoardTotal(vo);  //총 데이터 개수
		 
		 // 12/10 -> ceil(1.2) -> Integer(2.0) -> 2
		 int totalPage = (int) Math.ceil((double)total/unit);  // 총 페이지 수
		 
		 
		// 유효하지 않은 페이지 요청 시 첫 페이지로 설정
		 int viewPage = vo.getViewPage();
		 if(viewPage > totalPage || viewPage < 1) {
			 viewPage = 1;
		 }
		 
		 int startIndex = (viewPage - 1) * unit; 
		 int endIndex = unit;
		 
		 // 순번 내림차순
		 int startRowNo = total - (viewPage - 1) * unit;
		 
		 
		 vo.setStartIndex(startIndex);
		 vo.setEndIndex(endIndex);
		 
		 
		 List<?> list = boardService.SelectBoardList(vo);
		 
		 
		 model.addAttribute("startRowNo",startRowNo); 
		 model.addAttribute("total",total); 
		 model.addAttribute("totalPage",totalPage); 
		 model.addAttribute("boardList",list); 
		 model.addAttribute("viewPage", viewPage); // 현재 페이지
		 model.addAttribute("prevPage", Math.max(viewPage - 10, 1)); // 이전 페이지
		 model.addAttribute("nextPage", Math.min(viewPage + 10, totalPage)); // 다음 페이지
		 model.addAttribute("firstPage", 1); // 맨 앞 페이지
		 model.addAttribute("lastPage", totalPage); // 맨 뒤 페이지
		 
		 System.out.println("list:"+list);
		 System.out.println("list:"+list.size());
		 
		 System.out.println("startIndex: " + startIndex);
		 System.out.println("totalPage: " + totalPage);
		 System.out.println("endIndex: " + endIndex);
		 System.out.println("viewPage: " + viewPage);
		 
		 
		 return "board/boardList"; 
	 }
	 
	 
	 
	 @RequestMapping(value="/board/boardDetail.do")
	 public String selectBoardDetail(int idx, ModelMap model) throws Exception {
	     boardService.updateBoardViewcount(idx);
	     BoardVO vo = boardService.selectBoardDetail(idx);

	     // FileDetail 리스트 생성
	     List<FileDetail> fileDetails = new ArrayList<>();

	     // 파일 이름과 경로 가져오기
	     if (vo.getUploadFile() != null && !vo.getUploadFile().isEmpty() && 
	         vo.getFileName() != null && !vo.getFileName().isEmpty()) {

	         String[] uploadFiles = vo.getUploadFile().split(","); // 파일 경로
	         String[] fileNames = vo.getFileName().split(","); // 파일 이름

	         for (int i = 0; i < uploadFiles.length; i++) {
	             String fileName = fileNames[i]; // 파일 이름
	             String filePath = uploadFiles[i]; // 파일 경로
	             fileDetails.add(new FileDetail(fileName, filePath));
	             System.out.println("fileDetails"+ fileDetails.get(i).getName());
	    	     System.out.println("fileDetails"+filePath);
	         }
	     }
	     
	     // 모델에 파일 리스트 추가
	     model.addAttribute("fileDetails", fileDetails);
	     
	     

	     model.addAttribute("boardVO", vo);
	     return "board/boardDetail";
	 }


		/*
		 * C:\\tools\\eGovFrameDev-3.10.0-64bit\\eclipse-workspace\\prj\\src\\main\\
		 * webapp\\uploadFiles\\
		 */

	 @RequestMapping(value = "/board/fileDownload.do")
	 public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
	     String filenames = request.getParameter("fileName");
	     String uploadFiles = request.getParameter("uploadFile");
	     System.out.println("uploadFiles:"+uploadFiles);
	     
	     String realFilename = "C:\\tools\\eGovFrameDev-3.10.0-64bit\\eclipse-workspace\\prj\\src\\main\\webapp\\uploadFiles\\" +uploadFiles; // 실제 파일 경로 설정
	     System.out.println("Requested file path: " + realFilename);

	     if (filenames == null || filenames.isEmpty()) {
	         // 파일 이름이 없을 경우 처리
	         response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name is missing.");
	         return;
	     }

	     File file = new File(realFilename);
	     System.out.println("file" + file);
	     if (!file.exists()) {
	    	 System.out.println("File does not exist: " + realFilename);
	         // 파일이 존재하지 않을 경우 처리
	         response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
	         return;
	     }
	     System.out.println("Requested filename: " + filenames);
	     // 파일명 인코딩 처리
	     String browser = request.getHeader("User-Agent");
	     if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
	    	 filenames = URLEncoder.encode(filenames, "UTF-8").replaceAll("\\+", "%20");
	     } else {
	    	 filenames = new String(filenames.getBytes("UTF-8"), "ISO-8859-1");
	     }
	     System.out.println("Real filename path: " + realFilename);

	     // 응답 헤더 설정
	     response.setContentType("application/octet-stream");
	     response.setHeader("Content-Disposition", "attachment; filename=\"" + filenames + "\"");

	     // 파일 다운로드 처리
	     try (OutputStream os = response.getOutputStream(); FileInputStream fis = new FileInputStream(file)) {
	         byte[] buffer = new byte[512];
	         int bytesRead;

	         while ((bytesRead = fis.read(buffer)) != -1) {
	             os.write(buffer, 0, bytesRead);
	         }
	     } catch (Exception e) {
	         System.out.println("File download error: " + e.getMessage());
	         response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error downloading file.");
	     }
	 }

	 

	 
	 
	 
	 
	 @ResponseBody
	 @RequestMapping(value="/board/boardDelete.do")
	 public String boardDelete(int idx, BoardVO vo) throws Exception{
		 

		 int result = 0;
		 
		 int count = boardService.selectBoardPass(vo);
		 if( count == 1 ) {
			 result = boardService.boardDelete(idx);
		 } else {
			 result = -1;
		 }
		 
		 
		 System.out.println("입력된 비밀번호: " + vo.getUserPwd());
		 System.out.println("검증된 비밀번호 수: " + count);
		 
		 return result+"";
	 }
	 
	 @RequestMapping(value="/board/boardModifyWrite.do")
	 public String selectBoardModify(int idx, ModelMap model) throws Exception{
		 
			
		 boardService.updateBoardViewcount(idx);
	     BoardVO vo = boardService.selectBoardDetail(idx);

	     // FileDetail 리스트 생성
	     List<FileDetail> fileDetails = new ArrayList<>();

	     // 파일 이름과 경로 가져오기
	     if (vo.getUploadFile() != null && !vo.getUploadFile().isEmpty() && 
	         vo.getFileName() != null && !vo.getFileName().isEmpty()) {

	         String[] uploadFiles = vo.getUploadFile().split(","); // 파일 경로
	         String[] fileNames = vo.getFileName().split(","); // 파일 이름

	         for (int i = 0; i < uploadFiles.length; i++) {
	             String fileName = fileNames[i]; // 파일 이름
	             String filePath = uploadFiles[i]; // 파일 경로
	             fileDetails.add(new FileDetail(fileName, filePath));
	             System.out.println("fileDetails"+ fileDetails.get(i).getName());
	    	     System.out.println("fileDetails"+filePath);
	         }
	     }
	     
	     // 모델에 파일 리스트 추가
	     model.addAttribute("fileDetails", fileDetails);
	     
	     

	     model.addAttribute("boardVO", vo);
		 
			 
		 
		 return "board/boardModifyWrite";
	 }
	
	 
	 
	 
	 @Controller
	 public class FileController {

	     @RequestMapping("/board/boardModifySave.do")
	     public ResponseEntity<String> deleteFiles(@RequestParam("filesToDelete") List<String> filesToDelete,
	                                               @RequestParam("filePaths") List<String> filePaths,
	                                               @RequestParam("idx") int idx) throws Exception {
	         
	         BoardVO vo = boardService.selectBoardDetail(idx); 
	         
	         try {
	             // 1. 파일 시스템에서 삭제
	             for (String filesToDelete_ : filesToDelete) {
	                 File file = new File(filesToDelete_);
	                 System.out.println("file :      " + file);
	                 if (file.exists()) {
	                     boolean deleted = file.delete(); // 파일 삭제
	                     boardService.deleteFile(vo);
	                     boardService.deleteFileName(vo);
	                     if (deleted) {
	                         System.out.println(file + " 삭제됨");
	                     } else {
	                         System.out.println(file + " 삭제 실패");
	                     }
	                 } else {
	                     System.out.println(file + " 존재하지 않음");
	                 }
	             }

					/*
					 * // 2. DB에서 기존 파일 이름 가져오기 String realPath = vo.getUploadFile();
					 * 
					 * // 3. 기존 파일 목록을 리스트로 변환 List<String> fileNamesList = new
					 * ArrayList<>(Arrays.asList(realPath.split(",")));
					 * 
					 * // 4. 삭제할 파일 목록에서 파일 제거 for (String fileToDelete : filesToDelete) {
					 * fileNamesList.remove(fileToDelete); // 삭제할 파일 이름 제거 }
					 */

	             // 5. 수정된 파일 목록을 쉼표로 다시 연결
					/* String updatedFileNames = String.join(",", fileNamesList); */
					/* vo.setUploadFile(updatedFileNames); */ // 수정된 파일 이름 설정

	             // 6. DB에 수정된 파일 목록 업데이트
	             boardService.updateBoard(vo);

	             return ResponseEntity.ok("ok");
	         } catch (Exception e) {
	             e.printStackTrace();
	             return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
	         }
	     }
	 }


}
	 


	 
	 

