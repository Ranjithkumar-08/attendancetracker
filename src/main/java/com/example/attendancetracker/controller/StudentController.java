package com.example.attendancetracker.controller;

import com.example.attendancetracker.model.Attendance;
import com.example.attendancetracker.model.Student;
import com.example.attendancetracker.repository.StudentRepository;

import java.util.List;
import com.example.attendancetracker.repository.AttendanceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class StudentController {

    @Autowired
    private StudentRepository studentRepo;
    @Autowired
    private AttendanceRepository attendanceRepo;


    @GetMapping("/")
    public String redirectToSignin() {
        return "redirect:/logins";
    }

    
    @GetMapping("/registers")
    public String showRegistrationForm(Model model) {
        model.addAttribute("student", new Student());
        return "index";  
    }

  
    @PostMapping("/save")
    public String saveStudent(@ModelAttribute Student student) {
        studentRepo.save(student);
        return "redirect:/lists";
    }

 
    @GetMapping("/lists")
    public String listStudents(Model model) {
        model.addAttribute("students", studentRepo.findAll());
        return "list"; 
    }


    @GetMapping("/logins")
    public String showLoginPage() {
        return "signin"; 
    }

    @GetMapping("/attendance")
    public String viewAllAttendance(Model model) {
        List<Student> students = studentRepo.findAll();
        model.addAttribute("students", students);
        return "attendancesummary";
    }


    @GetMapping("/update/{id}")
    public String updateStudentForm(@PathVariable Long id, Model model) {
        Student student = studentRepo.findById(id).orElse(null);
        model.addAttribute("student", student);
        return "updatestudent"; 
    }


    @PostMapping("/updates")
    public String updateStudent(@ModelAttribute Student student) {
        studentRepo.save(student);
        return "redirect:/lists";
    }

  
    @GetMapping("/{id}/attendance")
    public String viewAttendance(@PathVariable Long id, Model model) {
        Student student = studentRepo.findById(id).orElse(null);
        if (student == null) {
            return "redirect:/lists";
        }

        List<Attendance> attendanceList = attendanceRepo.findByStudentId(id);

        model.addAttribute("student", student);
        model.addAttribute("attendanceList", attendanceList);

        return "attendance"; 
    }

    

    @GetMapping("/delete/{id}")
    public String deleteStudent(@PathVariable Long id) {
        studentRepo.deleteById(id);
        return "redirect:/lists";
    }
}
