package com.qc.qcsystem.service;
import com.qc.qcsystem.entity.Product;
import com.qc.qcsystem.mapper.ProductMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
@Service
public class ProductService {
    @Resource
    private ProductMapper productMapper;
    public List<Product> listAll(){
        return productMapper.selectAll();
    }
    public Product getById(String id){
        return productMapper.selectById(id);
    }
    public int add(Product product){
        return productMapper.insert(product);
    }
    public int edit(Product product){
        return productMapper.update(product);
    }
    public int delete(String id){
        return productMapper.deleteById(id);
    }
}