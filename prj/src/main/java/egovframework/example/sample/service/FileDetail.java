package egovframework.example.sample.service;

public class FileDetail {
	private String name; // 파일 이름
    private String path; // 파일 경로

    // 생성자
    public FileDetail(String name, String path) {
        this.name = name;
        this.path = path;
    }

    // getter
    public String getName() {
        return name;
    }

    public String getPath() {
        return path;
    }

    // setter (필요 시 사용)
    public void setName(String name) {
        this.name = name;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
