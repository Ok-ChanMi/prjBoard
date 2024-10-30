package egovframework.example.sample.service;


public class BoardVO {
	
	private int idx;
    private String userPwd;
    private String userYn;
    private String author;
    private String title;
    private String contents;
    private	String indate;
    private int viewCount;
    private int seq;
    private String fileName;
    private String uploadFile;
	
    
    private int viewPage = 1;
    private int startIndex; 
    private int endIndex;
    
    
    private String SearchConditions;
    private String SearchWord;
    
	
	public String getSearchConditions() {
		return SearchConditions;
	}
	public void setSearchConditions(String searchConditions) {
		SearchConditions = searchConditions;
	}
	public String getSearchWord() {
		return SearchWord;
	}
	public void setSearchWord(String searchWord) {
		SearchWord = searchWord;
	}
	
    
    
    public int getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}
	public int getEndIndex() {
		return endIndex;
	}
	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}
	public int getViewPage() {
		return viewPage;
	}
	public void setViewPage(int viewPage) {
		this.viewPage = viewPage;
	}
	
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserYn() {
		return userYn;
	}
	public void setUserYn(String userYn) {
		this.userYn = userYn;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(String uploadFile) {
		this.uploadFile = uploadFile;
	}
	
    
    
    
	
    
    
    
    
	
	
}
