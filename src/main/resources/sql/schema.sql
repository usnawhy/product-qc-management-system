-- ============================================================
-- 产品出厂质检记录管理系统 - 数据库脚本
-- 数据库: qc_product
-- 6张业务表: product, quality_standard, batch, qc_user, quality_record, dispose_record
-- ============================================================

CREATE DATABASE IF NOT EXISTS qc_product DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE qc_product;

-- -----------------------------------------------------------
-- 1. 用户表 (qc_user) - 质检员/管理员登录
-- -----------------------------------------------------------
DROP TABLE IF EXISTS qc_user;
CREATE TABLE qc_user (
    user_id     VARCHAR(32)  NOT NULL COMMENT '用户ID',
    user_name   VARCHAR(64)  NOT NULL COMMENT '用户名',
    password    VARCHAR(128) NOT NULL COMMENT '密码',
    role        VARCHAR(32)  DEFAULT '质检员' COMMENT '角色: 管理员/质检员',
    PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- -----------------------------------------------------------
-- 2. 产品表 (product)
-- -----------------------------------------------------------
DROP TABLE IF EXISTS product;
CREATE TABLE product (
    product_id       VARCHAR(32)  NOT NULL COMMENT '产品编号',
    product_name     VARCHAR(128) NOT NULL COMMENT '产品名称',
    spec_model       VARCHAR(128) DEFAULT NULL COMMENT '规格型号',
    standard_id      VARCHAR(32)  DEFAULT NULL COMMENT '关联质检标准ID',
    unit             VARCHAR(16)  DEFAULT NULL COMMENT '计量单位',
    production_craft VARCHAR(256) DEFAULT NULL COMMENT '生产工艺',
    PRIMARY KEY (product_id),
    KEY idx_standard (standard_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品表';

-- -----------------------------------------------------------
-- 3. 质检标准表 (quality_standard)
-- -----------------------------------------------------------
DROP TABLE IF EXISTS quality_standard;
CREATE TABLE quality_standard (
    standard_id    VARCHAR(32)  NOT NULL COMMENT '标准编号',
    standard_name  VARCHAR(128) NOT NULL COMMENT '标准名称',
    standard_desc  VARCHAR(512) DEFAULT NULL COMMENT '标准描述',
    check_items    TEXT         DEFAULT NULL COMMENT '检测项目(JSON)',
    create_time    DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (standard_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='质检标准表';

-- -----------------------------------------------------------
-- 4. 生产批次表 (batch)
-- -----------------------------------------------------------
DROP TABLE IF EXISTS batch;
CREATE TABLE batch (
    batch_id      VARCHAR(32)  NOT NULL COMMENT '批次编号',
    product_id    VARCHAR(32)  NOT NULL COMMENT '产品编号',
    produce_num   INT          DEFAULT 0 COMMENT '生产数量',
    produce_date  DATE         DEFAULT NULL COMMENT '生产日期',
    produce_team  VARCHAR(64)  DEFAULT NULL COMMENT '生产班组',
    batch_status  VARCHAR(32)  DEFAULT '待质检' COMMENT '批次状态: 待质检/合格/不合格/已处理',
    PRIMARY KEY (batch_id),
    KEY idx_product (product_id),
    KEY idx_status (batch_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='生产批次表';

-- -----------------------------------------------------------
-- 5. 质检记录表 (quality_record)
-- -----------------------------------------------------------
DROP TABLE IF EXISTS quality_record;
CREATE TABLE quality_record (
    record_id      VARCHAR(32)  NOT NULL COMMENT '记录编号',
    batch_id       VARCHAR(32)  NOT NULL COMMENT '批次编号',
    product_id     VARCHAR(32)  NOT NULL COMMENT '产品编号',
    checker_id     VARCHAR(32)  DEFAULT NULL COMMENT '质检员ID',
    check_num      INT          DEFAULT 0 COMMENT '抽检数量',
    qualified_num  INT          DEFAULT 0 COMMENT '合格数量',
    check_result   VARCHAR(32)  DEFAULT NULL COMMENT '质检结果: 合格/不合格',
    check_desc     VARCHAR(512) DEFAULT NULL COMMENT '质检描述',
    check_time     DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '质检时间',
    PRIMARY KEY (record_id),
    KEY idx_batch (batch_id),
    KEY idx_checker (checker_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='质检记录表';

-- -----------------------------------------------------------
-- 6. 不合格品处理记录表 (dispose_record)
-- -----------------------------------------------------------
DROP TABLE IF EXISTS dispose_record;
CREATE TABLE dispose_record (
    dispose_id    VARCHAR(32)  NOT NULL COMMENT '处理编号',
    record_id     VARCHAR(32)  NOT NULL COMMENT '关联质检记录ID',
    batch_id      VARCHAR(32)  NOT NULL COMMENT '批次编号',
    dispose_type  VARCHAR(32)  DEFAULT NULL COMMENT '处理方式: 返工/报废/降级',
    dispose_num   INT          DEFAULT 0 COMMENT '处理数量',
    dispose_desc  VARCHAR(512) DEFAULT NULL COMMENT '处理说明',
    dispose_time  DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '处理时间',
    PRIMARY KEY (dispose_id),
    KEY idx_record (record_id),
    KEY idx_batch (batch_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不合格品处理记录表';

-- -----------------------------------------------------------
-- 初始数据
-- -----------------------------------------------------------
INSERT INTO qc_user (user_id, user_name, password, role) VALUES
('admin', '系统管理员', '123456', '管理员'),
('qc001', '张质检', '123456', '质检员');

INSERT INTO quality_standard (standard_id, standard_name, standard_desc) VALUES
('STD001', '电子产品出厂检验标准', '外观、功能、性能全面检测'),
('STD002', '机械零件尺寸检验标准', '尺寸公差、表面粗糙度检测');

INSERT INTO product (product_id, product_name, spec_model, standard_id, unit, production_craft) VALUES
('P001', '智能温控器', 'TC-2024', 'STD001', '台', 'SMT贴片+整机装配'),
('P002', '精密齿轮', 'GR-M5', 'STD002', '件', '数控铣削+热处理');

INSERT INTO batch (batch_id, product_id, produce_num, produce_date, produce_team, batch_status) VALUES
('B20260601001', 'P001', 500, '2026-06-01', '甲班', '待质检'),
('B20260602001', 'P002', 1000, '2026-06-02', '乙班', '合格');
