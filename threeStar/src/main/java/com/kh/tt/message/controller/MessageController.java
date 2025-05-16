package com.kh.tt.message.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.kh.tt.message.model.vo.Message;
import com.kh.tt.calendar.model.vo.Calendar;
import com.kh.tt.chat.model.service.ChattingRoomService;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.message.model.service.MessageService;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private ChattingRoomService chattingRoomService;

    // 메시지 메인 화면 이동
    @RequestMapping("/mainForm")
    public String showMessageMainForm(@RequestParam(value = "roomId", required = false) Integer roomId,
                                      HttpSession session,
                                      Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/";

        // roomId가 없는 일반 채팅 목록 진입
        if (roomId == null) {
            model.addAttribute("page", "chat");
            return "message/messageMainForm";
        }

        // ✅ 채팅방 입장 시 추가 데이터 처리
        List<Member> memberList = chattingRoomService.getChatRoomMembers(roomId);
        model.addAttribute("chatRoomMembers", memberList);

        Member target = memberList.stream()
                .filter(m -> m.getMemNo() != loginMember.getMemNo())
                .findFirst()
                .orElse(null);
        model.addAttribute("targetNickname", target != null ? target.getMemName() : "이름없음");

        model.addAttribute("roomId", roomId);
        return "message/messageMainForm";
    }


    // 메시지 저장 요청 처리
    @PostMapping("/save")
    @ResponseBody
    public String saveMessage(@RequestBody Message message) {
        System.out.println("🔔 DB 저장 요청 받은 메시지: " + message);
        int result = messageService.saveMessage(message);
        return result > 0 ? "success" : "fail";
    }

    @RequestMapping("/messageForm")
    public String showMessageForm() {
        return "message/messageMainForm";
    }

    // 이전 채팅 불러오기
    @GetMapping(value = "/history", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<Message> getChatHistory(@RequestParam("roomId") int roomId) {
        return messageService.sendMessage(roomId);
    }

    // 상대방 닉네임 가져오기
    @RequestMapping("/roomForm")
    public String showMainForm(@RequestParam("roomId") int roomId,
                               HttpSession session,
                               Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        int myMemNo = loginMember.getMemNo();

        // 🔁 멤버 리스트 전체 가져오기
        List<Member> memberList = chattingRoomService.getChatRoomMembers(roomId);
        model.addAttribute("chatRoomMembers", memberList);

        // ✅ 상대 닉네임 추출 (본인 제외)
        Member targetMember = memberList.stream()
            .filter(m -> m.getMemNo() != myMemNo)
            .findFirst()
            .orElse(null);

        model.addAttribute("targetNickname", targetMember != null ? targetMember.getMemName() : "이름없음");
        model.addAttribute("roomId", roomId);

        return "message/mainMessageForm"; // 📄 JSP 경로
    }
    
    
    
//첨부파일 업로드
    @PostMapping("/upload")
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();

        try {
            ServletContext context = request.getSession().getServletContext();
            String savePath = context.getRealPath("/resources/uploadFiles/");

            File folder = new File(savePath);
            if (!folder.exists()) folder.mkdirs();

            String originName = file.getOriginalFilename();
            String saveName = System.currentTimeMillis() + "_" + originName;

            // 저장
            File targetFile = new File(savePath, saveName);
            file.transferTo(targetFile);
            
            System.out.println("💡 저장 경로: " + savePath);
            System.out.println("💡 파일명: " + saveName);

            // ✅ 응답에 반드시 imageUrl 포함!
            String contextPath = request.getContextPath();
            result.put("imageUrl", contextPath + "/resources/uploadFiles/" + saveName);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("imageUrl", null);  // ❌ 이게 프론트에서 에러 나는 이유!
        }

        return result;
    }

    @GetMapping("/download")
    @ResponseBody
    public ResponseEntity<Resource> download(@RequestParam("fileName") String fileName,
                                             HttpServletRequest request) throws IOException {
        String savePath = request.getSession().getServletContext().getRealPath("/resources/uploadFiles/");
        File file = new File(savePath, fileName);

        if (!file.exists()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        Resource resource = new FileSystemResource(file);

        String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

        // ✅ UTF-8로 명시적으로 처리 (브라우저 호환성 ↑)
        headers.add("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);

        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }

    
    @GetMapping("/download/files")
    @ResponseBody
    public List<Message> getFilesByRoomId(@RequestParam("roomId") int roomId) {
        System.out.println("📁 티서랍 파일 목록 요청 - roomId: " + roomId);
        return messageService.getFilesByRoomId(roomId);
    }
    
    
    @PostMapping("delete")
    @ResponseBody
    public String deleteMessage(@RequestParam("messageNo") int messageNo) {
    	System.out.println("✅ [Controller] deleteMessage 호출됨 → " + messageNo);
        try {
            int result = messageService.deleteMessage(messageNo);  // 실제 삭제 처리
            System.out.println("여기는 컨트롤러 " + result);
            
            return result > 0 ? "success" : "fail";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @GetMapping("/MessageCalender.do")
    @ResponseBody
    public List<Calendar> getCalendarEvents(@RequestParam("roomId") int roomId) {
        return messageService.getCalendarEvents(roomId);
    }
    
    
}


