package com.cs.project.bean;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name ="role")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"})
public class Role implements Serializable {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Basic
    @Column(name = "rolename")
    private String rolename;

    @Basic
    @Column(name = "remark")
    private String remark;

    @Basic
    @Column(name = "status")
    private long status;

    @Basic
    @Column(name = "sortnum")
    private long sortnum;

    public long getSortnum() {
        return sortnum;
    }

    public void setSortnum(long sortnum) {
        this.sortnum = sortnum;
    }

    public Integer getId() {
    return id;
    }

    public void setId(Integer id) {
    this.id = id;
    }


    public String getRolename() {
    return rolename;
    }

    public void setRolename(String rolename) {
    this.rolename = rolename;
    }


    public String getRemark() {
    return remark;
    }

    public void setRemark(String remark) {
    this.remark = remark;
    }


    public long getStatus() {
    return status;
    }

    public void setStatus(long status) {
    this.status = status;
    }


    @Override
    public String toString() {
        return "Role{" +
                "id=" + id +
                ", rolename='" + rolename + '\'' +
                ", remark='" + remark + '\'' +
                ", status=" + status +
                ", sortnum=" + sortnum +
                '}';
    }
}
