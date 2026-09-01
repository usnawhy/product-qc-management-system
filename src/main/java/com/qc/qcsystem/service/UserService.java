package com.qc.qcsystem.service;
import com.qc.qcsystem.entity.User;
import com.qc.qcsystem.mapper.UserMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
@Service
public class UserService {
    @Resource
    private UserMapper userMapper;
    public User login(String userId, String password){
        return userMapper.login(userId,password);
    }
}