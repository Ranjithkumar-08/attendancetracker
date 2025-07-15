<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Attendance Summary</title>
    <link rel="icon" type="image/png" href="/img/TwinBird.png">
    <style>
        body {
            background: url('/img/classroom.png') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            color: #fff;
        }

        .header {
            background-color: #000;
            padding: 20px;
            text-align: center;
            font-size: 28px;
            color: #00b8ff;
            font-weight: bold;
        }

        .controls {
            display: flex;
            justify-content: space-between;
            padding: 10px 20px;
            background: #000;
        }

        .controls button {
            padding: 10px 20px;
            background-color: #1DB954;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }

        .summary {
            margin: 50px auto;
            background: rgba(0, 0, 0, 0.85);
            padding: 30px;
            border-radius: 10px;
            width: 400px;
            text-align: center;
            box-shadow: 0 0 15px rgba(0, 184, 255, 0.3);
        }

        .summary h2 {
            color: #00b8ff;
            margin-bottom: 20px;
        }

        .summary p {
            font-size: 18px;
            margin: 10px 0;
        }

        .highlight {
            font-weight: bold;
            color: #00ff88;
        }

        .edit-btn {
            margin-top: 20px;
            padding: 10px 20px;
            background: #00b8ff;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
        }

        .edit-btn:hover {
            background: #0092cc;
        }
    </style>
</head>
<body>

<div class="header">Student Attendance Summary</div>

<div class="controls">
    <button onclick="goBack()">Back</button>
    <button onclick="logout()">Logout</button>
</div>

<div class="summary">
    <h2>${student.name} (ID: ${student.id})</h2>

    <c:set var="presentCount" value="0" />
    <c:forEach var="record" items="${attendanceList}">
        <c:if test="${record.status == 'Present'}">
            <c:set var="presentCount" value="${presentCount + 1}" />
        </c:if>
    </c:forEach>

    <c:set var="totalCount" value="${fn:length(attendanceList)}" />
    <c:set var="percentage" value="${totalCount > 0 ? (presentCount * 100 / totalCount) : 0}" />
	<p>Total Days: ${student.totalDays}</p>
	<p>Present Days: ${student.presentDays}</p>
	<p>Attendance %: ${student.attendancePercentage}</p>

<a href="/attendance/student/${student.id}/attendance-edit" class="edit-btn">Edit Attendance</a>


</div>

<script>
function goBack() {
    window.location.href = "/student/lists";
}

function logout() {
    window.location.href = "/student/logins";
}
</script>

</body>
</html>
