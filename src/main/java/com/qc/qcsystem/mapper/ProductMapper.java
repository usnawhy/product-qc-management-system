package com.qc.qcsystem.mapper;
import com.qc.qcsystem.entity.Product;
import java.util.List;
public interface ProductMapper {
    List<Product> selectAll();
    Product selectById(String productId);
    int insert(Product product);
    int update(Product product);
    int deleteById(String productId);
}