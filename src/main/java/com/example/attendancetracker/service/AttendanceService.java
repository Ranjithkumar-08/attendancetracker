package com.example.attendancetracker.service;

import com.example.attendancetracker.model.Student;
import java.util.List;

public interface AttendanceService {
    List<Student> getAllStudents();
    Student saveStudent(Student student);
    void deleteStudent(Long id);
}
