package com.cs.project.bean;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;


@Entity
@Table(name ="message")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"})
public class Message {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;


    @Column(name = "sender")
    private String sender;

    @Basic
    @Column(name = "receiver")
    private String receiver;

    @Basic
    @Column(name = "theme")
    private String theme;

    @Basic
    @Column(name = "content")
    private String content;

    @Basic
    @Column(name = "date")
    private String date;

    @Basic
    @Column(name = "status")
    private int status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Message() {
    }

    public Message(String sender, String receiver, String theme, String content, String date, int status) {
        this.sender = sender;
        this.receiver = receiver;
        this.theme = theme;
        this.content = content;
        this.date = date;
        this.status = status;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", sender='" + sender + '\'' +
                ", receiver='" + receiver + '\'' +
                ", theme='" + theme + '\'' +
                ", content='" + content + '\'' +
                ", date='" + date + '\'' +
                ", status=" + status +
                '}';
    }
}
