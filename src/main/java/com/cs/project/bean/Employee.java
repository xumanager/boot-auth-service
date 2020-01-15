package com.cs.project.bean;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;



@Entity
@Table(name ="t_employee")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"})
public class Employee {
    @Column(name = "employee_no")
    private String employeeNo;

    @Basic
    @Column(name = "employee_name")
    private String employeeName;

    @Basic
    @Column(name = "job")
    private String job;

    @Basic
    @Column(name = "date")
    private String date;

    @Basic
    @Column(name = "sal")
    private Double sal;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;



    public Employee() {
    super();
  }

  public String getEmployeeNo() {
    return employeeNo;
    }

    public void setEmployeeNo(String employeeNo) {
    this.employeeNo = employeeNo;
    }


    public String getEmployeeName() {
    return employeeName;
    }

    public void setEmployeeName(String employeeName) {
    this.employeeName = employeeName;
    }


    public String getJob() {
    return job;
    }

    public void setJob(String job) {
    this.job = job;
    }


    public String getDate() {
    return date;
    }

    public void setDate(String date) {
    this.date = date;
    }


    public Double getSal() {
    return sal;
    }

    public void setSal(Double sal) {
    this.sal = sal;
    }


    public Integer getId() {
    return id;
    }

    public void setId(Integer id) {
    this.id = id;
    }


    @Override
    public String toString() {
        return "Employee{" +
                "employeeNo='" + employeeNo + '\'' +
                ", employeeName='" + employeeName + '\'' +
                ", job='" + job + '\'' +
                ", date='" + date + '\'' +
                ", sal=" + sal +
                ", id=" + id +
                '}';
    }
}
