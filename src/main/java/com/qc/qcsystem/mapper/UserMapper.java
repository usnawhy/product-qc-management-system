package com.qc.qcsystem.mapper;
import com.qc.qcsystem.entity.User;
import org.apache.ibatis.annotations.Param;
public interface UserMapper {
    User login(@Param("userId") String userId, @Param("password") String password);
}