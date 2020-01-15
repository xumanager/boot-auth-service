package com.cs.project.bean;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;

@Entity
@Table(name ="resource")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"})
public class Resource {
  @Id
  @Column(name = "id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer id;
  @Basic
  @Column(name = "keyname")
  private String keyname;
  @Basic
  @Column(name = "val")
  private String val;
  @Basic
  @Column(name = "sortnum")
  private long sortnum;
  @Basic
  @Column(name = "status")
  private long status;
  @Basic
  @Column(name = "remark")
  private String remark;
  @Basic
  @Column(name = "classify")
  private String classify;

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getKeyname() {
    return keyname;
  }

  public void setKeyname(String keyname) {
    this.keyname = keyname;
  }

  public String getVal() {
    return val;
  }

  public void setVal(String val) {
    this.val = val;
  }

  public long getSortnum() {
    return sortnum;
  }

  public void setSortnum(long sortnum) {
    this.sortnum = sortnum;
  }

  public long getStatus() {
    return status;
  }

  public void setStatus(long status) {
    this.status = status;
  }

  public String getRemark() {
    return remark;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }

  public String getClassify() {
    return classify;
  }

  public void setClassify(String classify) {
    this.classify = classify;
  }

  @Override
  public String toString() {
    return "Resource{" +
            "id=" + id +
            ", key='" + keyname + '\'' +
            ", val='" + val + '\'' +
            ", sortnum=" + sortnum +
            ", status=" + status +
            ", remark='" + remark + '\'' +
            ", classify='" + classify + '\'' +
            '}';
  }
}
