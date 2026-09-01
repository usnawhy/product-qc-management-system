package com.qc.qcsystem.service;
import com.qc.qcsystem.entity.Batch;
import com.qc.qcsystem.mapper.BatchMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
@Service
public class BatchService {
    @Resource
    private BatchMapper batchMapper;
    public List<Batch> listAll(){
        return batchMapper.selectAll();
    }
    public Batch getById(String id){
        return batchMapper.selectById(id);
    }
    public int add(Batch batch){
        return batchMapper.insert(batch);
    }
    public int edit(Batch batch){
        return batchMapper.update(batch);
    }
    public int delete(String id){
        return batchMapper.deleteById(id);
    }
}