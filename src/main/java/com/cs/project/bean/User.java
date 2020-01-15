package com.cs.project.bean;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Entity
@Table(name ="user")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"})
public class User {

  @Id
  @Column(name = "id")
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Integer id;

  @Basic
  @Column(name="username")
  private String username;

  @Basic
  @Column(name="password")
  private String password;


  @OneToOne(cascade = {CascadeType.PERSIST,CascadeType.REFRESH})
  @JoinColumn(name="eid",referencedColumnName = "id")
  private Employee employee;

  @Basic
  @Column(name="status")
  private long status;


  @Basic
  @Column(name="phone")
  private String phone;

  @Basic
  @Column(name="email")
  private String email;

  @ManyToMany(cascade = {CascadeType.PERSIST,CascadeType.REFRESH})                                      //指定多对多关系    //默认懒加载,只有调用getter方法时才加载数据
  @JoinTable(name="user_role",                       //指定第三张中间表名称
          joinColumns={@JoinColumn(name="uid")},             //本表主键userId与第三张中间表user_role_tb的外键user_role_tb_user_id对应
          inverseJoinColumns={@JoinColumn(name="rid")})  //多对多关系另一张表与第三张中间表表的外键的对应关系
  @NotFound(action = NotFoundAction.IGNORE)	//NotFound : 意思是找不到引用的外键数据时忽略，NotFound默认是exception
  private List<Role> roleSet = new ArrayList<Role>();//用户所拥有的角色集合

  public List<Role> getRoleSet() {
    return roleSet;
  }

  public void setRoleSet(List<Role> roleSet) {
    this.roleSet = roleSet;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public User() {
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }


  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }


  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }


  public Employee getEmployee() {
    return employee;
  }

  public void setEmployee(Employee employee) {
    this.employee = employee;
  }

  public long getStatus() {
    return status;
  }

  public void setStatus(long status) {
    this.status = status;
  }




  @Override
  public String toString() {
    return "User{" +
            "id=" + id +
            ", username='" + username + '\'' +
            ", password='" + password + '\'' +
            ", employee=" + employee +
            ", status=" + status +
            ", phone='" + phone + '\'' +
            ", email='" + email + '\'' +
            ", roleSet=" + roleSet +
            '}';
  }
}
