package com.example.attendancetracker.controller;

import com.example.attendancetracker.model.Attendance;
import com.example.attendancetracker.model.Student;
import com.example.attendancetracker.repository.AttendanceRepository;
import com.example.attendancetracker.repository.StudentRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {

    @Autowired
    private AttendanceRepository attendanceRepo;

    @Autowired
    private StudentRepository studentRepo;

    @GetMapping("/student/{id}/attendance")
    public String viewAttendanceSummary(@PathVariable Long id, Model model) {
        Student student = studentRepo.findById(id).orElse(null);
        List<Attendance> attendanceList = attendanceRepo.findByStudentId(id);

        model.addAttribute("student", student);
        model.addAttribute("attendanceList", attendanceList);

        return "attendance"; // Show saved summary
    }


    @GetMapping("/student/{id}/records")
    public String viewStudentRawAttendance(@PathVariable Long id, Model model) {
        Student student = studentRepo.findById(id).orElse(null);
        List<Attendance> attendanceList = attendanceRepo.findByStudentId(id);

        model.addAttribute("student", student);
        model.addAttribute("attendanceList", attendanceList);
        return "attendance";
    }

    @GetMapping("/student/{id}/attendance-edit")
    public String editAttendanceForm(@PathVariable Long id, Model model) {
        Student student = studentRepo.findById(id).orElse(null);
        List<Attendance> attendanceList = attendanceRepo.findByStudentId(id);

        long totalDays = attendanceList.size();
        long presentDays = attendanceList.stream()
                .filter(a -> "Present".equalsIgnoreCase(a.getStatus()))
                .count();

        model.addAttribute("student", student);
        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("totalDays", totalDays);
        model.addAttribute("presentDays", presentDays);

        return "attendance-edit";
    }


    @PostMapping("/student/{id}/attendance-update")
    public String updateAttendance(@PathVariable Long id,
                                   @RequestParam("attendanceIds") List<Long> attendanceIds,
                                   @RequestParam("statuses") List<String> statuses) {
        for (int i = 0; i < attendanceIds.size(); i++) {
            Attendance attendance = attendanceRepo.findById(attendanceIds.get(i)).orElse(null);
            if (attendance != null) {
                attendance.setStatus(statuses.get(i));
                attendanceRepo.save(attendance);
            }
        }
        return "redirect:/attendance/student/" + id + "/attendance";
    }

    @GetMapping("/mark")
    public String showAttendanceForm(Model model) {
        model.addAttribute("students", studentRepo.findAll());
        return "attendance-mark";
    }

    @PostMapping("/mark")
    public String submitAttendance(@RequestParam Long studentId,
                                   @RequestParam String status,
                                   @RequestParam String recordedBy) {
        Student student = studentRepo.findById(studentId).orElse(null);
        if (student == null) throw new IllegalArgumentException("Invalid student ID: " + studentId);

        Attendance attendance = new Attendance();
        attendance.setDate(LocalDate.now());
        attendance.setStatus(status);
        attendance.setRecordedBy(recordedBy);
        attendance.setStudent(student);

        attendanceRepo.save(attendance);
        return "redirect:/attendance/student/" + studentId + "/attendance";
    }

    @PostMapping("/student/{id}/update-summary")
    public String updateAttendanceSummary(@PathVariable Long id,
                                          @RequestParam int presentDays,
                                          @RequestParam int totalDays) {
        Student student = studentRepo.findById(id).orElse(null);
        if (student != null) {
            double percentage = totalDays > 0 ? (presentDays * 100.0) / totalDays : 0;
            student.setPresentDays(presentDays);
            student.setTotalDays(totalDays);
            student.setAttendancePercentage(percentage);
            studentRepo.save(student);
        }
        return "redirect:/attendance/student/" + id + "/attendance";
    }

}
