package com.qc.qcsystem.controller;
import com.qc.qcsystem.entity.Batch;
import com.qc.qcsystem.service.BatchService;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
@RestController
@RequestMapping("/batch")
public class BatchController {
    @Resource
    private BatchService batchService;
    @GetMapping("/list")
    public List<Batch> list(){
        return batchService.listAll();
    }
    @GetMapping("/get")
    public Batch get(String batchId){
        return batchService.getById(batchId);
    }
    @PostMapping("/add")
    public String add(@RequestBody Batch batch){
        batchService.add(batch);
        return "新增批次成功";
    }
    @PostMapping("/update")
    public String update(@RequestBody Batch batch){
        batchService.edit(batch);
        return "修改批次成功";
    }
    @GetMapping("/delete")
    public String delete(String batchId){
        batchService.delete(batchId);
        return "删除批次成功";
    }
}
