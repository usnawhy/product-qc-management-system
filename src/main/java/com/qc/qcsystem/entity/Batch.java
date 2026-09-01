package com.qc.qcsystem.entity;
import lombok.Data;
import java.util.Date;
@Data
public class Batch {
    private String batchId;
    private String productId;
    private Integer produceNum;
    private Date produceDate;
    private String produceTeam;
    private String batchStatus;
}