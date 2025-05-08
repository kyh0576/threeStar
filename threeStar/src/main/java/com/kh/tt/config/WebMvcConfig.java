package com.kh.tt.config;

import java.io.File;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        // 개발용 (이클립스 tmp0)
        registry.addResourceHandler("/resources/uploadFiles/**")
                .addResourceLocations("file:///" + System.getProperty("user.dir") + "/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/tt/resources/uploadFiles/");

        // 배포용 (웹경로 /resources/uploadFiles/)
        registry.addResourceHandler("/resources/uploadFiles/**")
                .addResourceLocations("/resources/uploadFiles/");
    }
}


