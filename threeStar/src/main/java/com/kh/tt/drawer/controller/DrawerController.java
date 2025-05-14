package com.kh.tt.drawer.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.tt.drawer.model.service.DrawerServiceImpl;
import com.kh.tt.message.model.vo.Message;

@Controller
public class DrawerController {

	@Autowired
	public DrawerServiceImpl dService;
	
	@RequestMapping(value="drawerSelect.do")
	public String selectDrawer(Message d, Model model) {
		model.addAttribute("page", "chat");
		
		List<Message> list = dService.selectDrawer(d);
		
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
