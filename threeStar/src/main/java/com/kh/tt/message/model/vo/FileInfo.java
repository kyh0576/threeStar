package com.kh.tt.message.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class FileInfo {

    private String name;      // 파일명
    private String type;      // MIME type (ex image/png)
    private String fileUrl;   // base64 데이터
}
