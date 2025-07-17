<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance</title>
    <link rel="icon" type="image/png" href="/img/TwinBird.png">
    <style>
        body {
            background: url('/img/classroom.png') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
            margin: 0;
        }

        .header {
            background-color: #000;
            padding: 20px;
            text-align: center;
            font-size: 28px;
            color: #00b8ff;
            font-weight: bold;
        }

        .container {
            width: 400px;
            margin: 50px auto;
            padding: 30px;
            background-color: rgba(0, 0, 0, 0.85);
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 184, 255, 0.3);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #00ff88;
        }

        label {
            display: block;
            margin: 10px 0 5px;
        }

        select, input, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: none;
            font-size: 14px;
        }

        input, select {
            background: #1e1e1e;
            color: #fff;
        }

        button {
            background-color: #00b8ff;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background-color: #0092cc;
        }

        .controls {
            text-align: center;
            margin-top: 20px;
        }

        .controls button {
            width: 48%;
            margin: 0 1%;
        }
    </style>
</head>
<body>

<div class="header">Mark Student Attendance</div>

<div class="container">
    <form action="/attendance/mark" method="post">
        <h2>Attendance Form</h2>

        <!-- Student Dropdown -->
        <label for="studentId">Student</label>
        <select name="studentId" id="studentId" required>
            <option value="">-- Select Student --</option>
            <c:forEach var="student" items="${students}">
                <option value="${student.id}">${student.name} (ID: ${student.id})</option>
            </c:forEach>
        </select>

        <!-- Status Dropdown -->
        <label for="status">Attendance Status</label>
        <select name="status" id="status" required>
            <option value="Present">Present</option>
            <option value="Absent">Absent</option>
            <option value="Late">Late</option>
            <option value="Excused">Excused</option>
        </select>

        <!-- Recorded By -->
        <label for="recordedBy">Recorded By</label>
        <input type="text" name="recordedBy" id="recordedBy" required placeholder="e.g. Mr. Kumar">

        <!-- Submit/Cancel Buttons -->
        <div class="controls">
            <button type="submit">Save Attendance</button>
            <button type="button" onclick="goBack()">Cancel</button>
        </div>
    </form>
</div>

<script>
    function goBack() {
        window.location.href = "/lists";
    }
</script>

</body>
</html>
