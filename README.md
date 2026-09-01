# 产品出厂质检记录管理系统

> 软件分析与建模课程设计 | 2026.06

## 项目简介

基于 SpringBoot + MyBatis + MySQL 的产品出厂质检记录管理系统，实现了用户登录、产品管理、生产批次管理等核心功能。系统采用 PowerDesigner 进行数据库建模，遵循标准的 MVC 分层架构，是一个典型的 Java 后端工程实践项目。

## 技术栈

| 分类 | 技术 |
|------|------|
| 后端框架 | SpringBoot 2.6.13 |
| ORM框架 | MyBatis (XML映射) |
| 数据库 | MySQL 8.0 |
| 工具库 | Lombok |
| 建模工具 | PowerDesigner |
| JDK版本 | Java 1.8 |
| 构建工具 | Maven |

## 功能模块

### 1. 用户登录模块
- 接口：`GET /login?userId=xxx&password=xxx`
- 支持管理员/质检员角色区分
- 统一返回结果格式（code/msg/data）

### 2. 产品管理模块
- 接口：`/product/list`、`/product/get`、`/product/add`、`/product/update`、`/product/delete`
- 产品信息的增删改查（CRUD）
- 关联质检标准

### 3. 生产批次管理模块
- 接口：`/batch/list`、`/batch/get`、`/batch/add`、`/batch/update`、`/batch/delete`
- 批次状态管理（待质检/合格/不合格/已处理）
- 关联产品、生产班组

## 数据库设计

数据库名：`qc_product`，共6张业务表：

| 表名 | 说明 | 核心字段 |
|------|------|----------|
| qc_user | 用户表 | user_id, user_name, password, role |
| product | 产品表 | product_id, product_name, spec_model, standard_id |
| quality_standard | 质检标准表 | standard_id, standard_name, check_items |
| batch | 生产批次表 | batch_id, product_id, produce_num, batch_status |
| quality_record | 质检记录表 | record_id, batch_id, checker_id, check_result |
| dispose_record | 不合格品处理表 | dispose_id, record_id, dispose_type, dispose_num |

数据库脚本见：`src/main/resources/sql/schema.sql`

## 项目结构

```
qc-system/
├── src/main/java/com/qc/qcsystem/
│   ├── QcSystemApplication.java      # 启动类 (@MapperScan)
│   ├── controller/                    # 控制层
│   │   ├── LoginController.java
│   │   ├── ProductController.java
│   │   └── BatchController.java
│   ├── service/                       # 业务层
│   │   ├── UserService.java
│   │   ├── ProductService.java
│   │   └── BatchService.java
│   ├── mapper/                        # 数据访问层接口
│   │   ├── UserMapper.java
│   │   ├── ProductMapper.java
│   │   └── BatchMapper.java
│   └── entity/                        # 实体类
│       ├── User.java
│       ├── Product.java
│       └── Batch.java
├── src/main/resources/
│   ├── application.yml                # 配置文件
│   ├── mapper/                        # MyBatis XML映射文件
│   │   ├── UserMapper.xml
│   │   ├── ProductMapper.xml
│   │   └── BatchMapper.xml
│   └── sql/schema.sql                 # 数据库建表脚本
└── pom.xml
```

## 运行方式

1. **创建数据库**：执行 `src/main/resources/sql/schema.sql` 初始化数据库和表
2. **修改配置**：编辑 `application.yml`，将 `password` 改为你的MySQL密码
3. **启动项目**：
   ```bash
   mvn clean compile
   mvn spring-boot:run
   ```
4. **访问测试**：
   - 登录：`http://localhost:8080/login?userId=admin&password=123456`
   - 产品列表：`http://localhost:8080/product/list`
   - 批次列表：`http://localhost:8080/batch/list`

## 项目亮点

1. **标准MVC分层架构**：Controller → Service → Mapper → Entity，职责清晰
2. **MyBatis XML映射**：SQL与Java代码分离，支持复杂SQL编写和优化
3. **PowerDesigner建模**：从概念模型(CDM)到物理模型(PDM)的完整数据库设计流程
4. **驼峰命名映射**：MyBatis配置 `map-underscore-to-camel-case`，数据库下划线字段自动映射Java驼峰属性
5. **统一返回格式**：登录接口采用 code/msg/data 统一响应格式
6. **Lombok简化代码**：使用 `@Data` 注解自动生成 getter/setter/toString
7. **RESTful风格接口**：GET查询、POST新增/修改，遵循HTTP方法语义
