package com.itwill.running.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

import com.itwill.running.domain.User;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserItemDto {
    private String userId;
    private String nickname;
    private String username;

    public static UserItemDto fromEntity(User user) {
        return UserItemDto.builder()
                .userId(user.getUserId())
                .nickname(user.getNickname())
                .username(user.getUsername())
                .build();
    }

}
