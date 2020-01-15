package com.cs.project.bean;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;

@Entity
@Table(name ="user_role")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"})
public class UserRole {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Basic
    @Column(name = "uid")
    private long uid;

    @Basic
    @Column(name = "rid")
    private long rid;

    @Basic
    @Column(name = "status")
    private long status;

    public UserRole(){

    }

    public long getId() {
    return id;
    }

    public void setId(long id) {
    this.id = id;
    }


    public long getUid() {
    return uid;
    }

    public void setUid(long uid) {
    this.uid = uid;
    }


    public long getRid() {
    return rid;
    }

    public void setRid(long rid) {
    this.rid = rid;
    }


    public long getStatus() {
    return status;
    }

    public void setStatus(long status) {
    this.status = status;
    }

}
