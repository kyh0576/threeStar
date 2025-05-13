package com.kh.tt.message.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Message {

    private int messageNo;
    private String messageContent;
    private Date createDate;
    private Date sendTime;
    private String originName;
    private String changeName;
    private int msChatId;
    private int msMemNo;

    private String sender;
    private String text;
    private String time;

    private String type;       // ✅ chat, file 구분 (이미 있음)
    private String fileType;   // ✅ 파일의 MIME 타입 (image/png 등)
    private String fileUrl;    // ✅ 파일 경로(base64 또는 서버 저장 url)
    
    

    // ✅ 내부 파일 메타 정보용 (option)
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @ToString
    public static class FileMeta {
        private String name;     // 파일 원본 이름
        private String type;     // 파일 타입
        private String fileUrl;  // 파일 경로(base64 or url)
    }
}
