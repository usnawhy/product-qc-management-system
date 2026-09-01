package com.qc.qcsystem.controller;
import com.qc.qcsystem.entity.Product;
import com.qc.qcsystem.service.ProductService;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
@RestController
@RequestMapping("/product")
public class ProductController {
    @Resource
    private ProductService productService;
    // 查询全部
    @GetMapping("/list")
    public List<Product> list(){
        return productService.listAll();
    }
    // 根据id查询
    @GetMapping("/get")
    public Product get(String productId){
        return productService.getById(productId);
    }
    // 新增
    @PostMapping("/add")
    public String add(@RequestBody Product product){
        productService.add(product);
        return "新增产品成功";
    }
    // 修改
    @PostMapping("/update")
    public String update(@RequestBody Product product){
        productService.edit(product);
        return "修改产品成功";
    }
    // 删除
    @GetMapping("/delete")
    public String delete(String productId){
        productService.delete(productId);
        return "删除产品成功";
    }
}