package com.qc.qcsystem.mapper;
import com.qc.qcsystem.entity.Batch;
import java.util.List;
public interface BatchMapper {
    List<Batch> selectAll();
    Batch selectById(String batchId);
    int insert(Batch batch);
    int update(Batch batch);
    int deleteById(String batchId);
}
