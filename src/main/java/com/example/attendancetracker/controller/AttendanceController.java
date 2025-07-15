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

    // ✅ View raw attendance records for a student
    @GetMapping("/student/{id}")
    public String viewStudentAttendance(@PathVariable Long id, Model model) {
        Student student = studentRepo.findById(id).orElse(null);
        List<Attendance> attendanceList = attendanceRepo.findByStudentId(id);

        model.addAttribute("student", student);
        model.addAttribute("attendanceList", attendanceList);
        return "attendance";
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
            studentRepo.save(student); // ✅ Saving to DB
        }
        return "redirect:/student/" + id + "/attendance"; // ✅ Go back to summary
    }


    // ✅ View summary with % present etc.
    @GetMapping("/student/{id}/attendance")
    public String viewAttendanceSummary(@PathVariable Long id, Model model) {
        Student student = studentRepo.findById(id).orElse(null);
        if (student == null) {
            // Optional: redirect or show error
            return "redirect:/student/lists";
        }

        List<Attendance> attendanceList = attendanceRepo.findByStudentId(id);

        long totalDays = 0;
        long presentDays = 0;
        double percentage = 0.0;

        if (attendanceList != null && !attendanceList.isEmpty()) {
            totalDays = attendanceList.size();
            presentDays = attendanceList.stream()
                    .filter(a -> "Present".equalsIgnoreCase(a.getStatus()))
                    .count();
            percentage = (presentDays * 100.0) / totalDays;
        }

        model.addAttribute("student", student);
        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("totalDays", totalDays);
        model.addAttribute("presentDays", presentDays);
        model.addAttribute("percentage", String.format("%.2f", percentage));

        return "attendance"; // Make sure this JSP exists
    }



    // ✅ Show attendance edit form
    @GetMapping("/student/{id}/attendance-edit")
    public String editAttendanceForm(@PathVariable Long id, Model model) {
        Student student = studentRepo.findById(id).orElse(null);
        List<Attendance> attendanceList = attendanceRepo.findByStudentId(id);
        model.addAttribute("student", student);
        model.addAttribute("attendanceList", attendanceList);
        return "attendance-edit";
    }

    // ✅ Update individual attendance records
    @PostMapping("/student/{id}/attendance-update")
    public String updateAttendance(
            @PathVariable Long id,
            @RequestParam("attendanceIds") List<Long> attendanceIds,
            @RequestParam("statuses") List<String> statuses
    ) {
        for (int i = 0; i < attendanceIds.size(); i++) {
            Attendance attendance = attendanceRepo.findById(attendanceIds.get(i)).orElse(null);
            if (attendance != null) {
                attendance.setStatus(statuses.get(i));
                attendanceRepo.save(attendance);
            }
        }
        return "redirect:/attendance/student/" + id + "/attendance"; // ✅ redirect to summary
    }

    // ✅ Show attendance marking form
    @GetMapping("/mark")
    public String showAttendanceForm(Model model) {
        model.addAttribute("students", studentRepo.findAll());
        return "attendance-mark";
    }

    // ✅ Submit new attendance record
    @PostMapping("/mark")
    public String submitAttendance(@RequestParam Long studentId,
                                   @RequestParam String status,
                                   @RequestParam String recordedBy) {
        Student student = studentRepo.findById(studentId).orElse(null);
        if (student == null) {
            throw new IllegalArgumentException("Invalid student ID: " + studentId);
        }

        Attendance attendance = new Attendance();
        attendance.setDate(LocalDate.now());
        attendance.setStatus(status);
        attendance.setRecordedBy(recordedBy);
        attendance.setStudent(student);

        attendanceRepo.save(attendance);

        return "redirect:/attendance/student/" + studentId + "/attendance"; // Go to summary
    }
}
