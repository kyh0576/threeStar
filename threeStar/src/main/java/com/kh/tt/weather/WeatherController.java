package com.kh.tt.weather;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
public class WeatherController {

    @GetMapping("/weather/today")
    @ResponseBody
    public String getWeather() {
        try {
            // 시간 계산
            LocalDateTime now = LocalDateTime.now().minusMinutes(40);
            String baseDate = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
            String baseTime = getBaseTime(now.getHour());

            String serviceKey = "VSgXc34Vs94ijfKVTpeJr85n70S9Xq9bY8PLyw9wCrGAzraqE4Gj6ecSZ88ZSiuSvN3JC1aXQZ0NVZDGuuugoA==";

            String apiUrl = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
                    + "?serviceKey=" + serviceKey
                    + "&numOfRows=100&pageNo=1&dataType=JSON"
                    + "&base_date=" + baseDate
                    + "&base_time=" + baseTime
                    + "&nx=60&ny=127";

            RestTemplate restTemplate = new RestTemplate();
            return restTemplate.getForObject(apiUrl, String.class);

        } catch (Exception e) {
            return "{\"error\": \"기상청 API 오류: " + e.getMessage() + "\"}";
        }
    }

    private String getBaseTime(int hour) {
        int[] baseHours = {23, 20, 17, 14, 11, 8, 5, 2};
        for (int h : baseHours) {
            if (hour >= h) return String.format("%02d00", h);
        }
        return "2300";
    }
}
