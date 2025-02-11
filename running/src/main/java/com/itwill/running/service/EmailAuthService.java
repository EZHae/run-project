package com.itwill.running.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Service
public class EmailAuthService {
	@Autowired
    private JavaMailSender mailSender;
    
    //토큰 이메일 전송 서비스
    public void sendVerificationEmail(String toEmail, String verificationToken) {
        String subject = "회원가입 이메일 인증";
        String verificationLink = "http://localhost:8080/running/verify?token=" + verificationToken;
        String content = "아래 링크를 클릭하면 이메일 인증이 완료됩니다. 다시 로그인해주세요.:<br><a href='" + verificationLink + "'>이메일 인증</a>";

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setFrom("runningproject157@gmail.com");
            helper.setTo(toEmail);
            helper.setSubject(subject);
            helper.setText(content, true); // HTML 형식으로 전송
            
            mailSender.send(message);
            System.out.println("이메일이 성공적으로 전송되었습니다!");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
