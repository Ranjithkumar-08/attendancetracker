package com.example.attendancetracker.repository;

import com.example.attendancetracker.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository<Student, Long> {
}
