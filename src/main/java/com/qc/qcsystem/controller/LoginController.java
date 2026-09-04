package com.qc.qcsystem.controller;

import com.qc.qcsystem.entity.User;
import com.qc.qcsystem.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@RestController
public class LoginController {

    @Resource
    private UserService userService;

    @GetMapping("/login")
    public Map<String,Object> login(@RequestParam String userId, @RequestParam String password){
        Map<String,Object> res = new HashMap<>();
        User loginUser = userService.login(userId,password);
        if(loginUser != null){
            res.put("code",200);
            res.put("msg","登录成功");
            res.put("data",loginUser);
        }else{
            res.put("code",500);
            res.put("msg","账号或密码错误");
        }
        return res;
    }
}
