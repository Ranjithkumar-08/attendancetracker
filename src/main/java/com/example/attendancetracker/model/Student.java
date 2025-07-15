package com.example.attendancetracker.model;

import jakarta.persistence.*;

@Entity
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    
    private Integer totalDays = 0;
    private Integer presentDays = 0;
    private Double attendancePercentage = 0.0;

    private String name;
    private String department;
    private String email;

    // ✅ Getter
    public Long getId() {
        return id;
    }

    // ✅ Add this setter to fix the issue
    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    

    public Integer getTotalDays() {
        return totalDays != null ? totalDays : 0;
    }

    public void setTotalDays(Integer totalDays) {
        this.totalDays = totalDays;
    }

    public Integer getPresentDays() {
        return presentDays != null ? presentDays : 0;
    }

    public void setPresentDays(Integer presentDays) {
        this.presentDays = presentDays;
    }

    public Double getAttendancePercentage() {
        return attendancePercentage != null ? attendancePercentage : 0.0;
    }

    public void setAttendancePercentage(Double attendancePercentage) {
        this.attendancePercentage = attendancePercentage;
    }
}
