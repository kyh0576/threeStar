package com.kh.tt.drawer.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.tt.chat.model.service.ChattingRoomService;
import com.kh.tt.drawer.model.service.DrawerServiceImpl;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.message.model.service.MessageService;
import com.kh.tt.message.model.vo.Message;

@Controller
public class DrawerController {

	@Autowired
	public DrawerServiceImpl dService;

    @Autowired
    private ChattingRoomService chattingRoomService;
	
	@RequestMapping(value="drawerSelect.do")
	public String selectDrawer(@RequestParam(value = "roomId", required = false) Integer roomId, HttpSession session, Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/";

        // roomId가 없는 일반 채팅 목록 진입
        if (roomId == null) {
            model.addAttribute("page", "chat");
            return "drawer/drawerAll";
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
        
		List<Message> list = dService.selectDrawer(roomId);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			return "drawer/drawerAll";
		}else {
			model.addAttribute("errorMsg", "파일 조회에 실패했습니다.");
			return "drawer/drawerAll";
		}
	}
	
	@RequestMapping(value="fileDownload.do")
	public ResponseEntity<Resource> download(@RequestParam("fileName") String fileName, HttpServletRequest request) throws IOException {
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

}
