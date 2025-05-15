package com.kh.tt.drawer.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public void fileDownload(@RequestParam("fileName") String fileName, HttpServletRequest request, HttpServletResponse response) {
        String rootPath = request.getSession().getServletContext().getRealPath("resources");
        String filePath = rootPath + "/uploads/message/";
        
        File file = new File(filePath + fileName);
        
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.setContentLength((int) file.length());
        
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = fis.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            out.flush();
            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
