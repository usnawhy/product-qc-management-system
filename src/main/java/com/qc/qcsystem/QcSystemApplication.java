package com.qc.qcsystem;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.qc.qcsystem.mapper") // 扫描mapper接口包
public class QcSystemApplication {
    public static void main(String[] args) {
        SpringApplication.run(QcSystemApplication.class, args);
    }
}