<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Students Attendance Summary</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #1a1a1a;
            color: white;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            padding: 20px;
            background-color: #000;
            color: #00b8ff;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #2c2c2c;
            color: white;
            box-shadow: 0 0 10px rgba(0, 184, 255, 0.3);
        }

        th, td {
            padding: 12px 16px;
            text-align: center;
            border: 1px solid #444;
        }

        th {
            background-color: #111;
            color: #00ff88;
        }

        tr:hover {
            background-color: #444;
        }

        .btn {
            background-color: #00b8ff;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #0092cc;
        }
    </style>
</head>
<body>

<h2>All Students Attendance Summary</h2>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Total Days</th>
            <th>Days Present</th>
            <th>Attendance %</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="student" items="${students}">
            <c:set var="total" value="${fn:length(student.attendanceList)}" />
            <c:set var="present" value="0" />
            <c:forEach var="a" items="${student.attendanceList}">
                <c:if test="${a.status == 'Present'}">
                    <c:set var="present" value="${present + 1}" />
                </c:if>
            </c:forEach>
            <c:set var="percent" value="${total > 0 ? (present * 100 / total) : 0}" />

            <tr>
                <td>${student.id}</td>
                <td>${student.name}</td>
                <td>${total}</td>
                <td>${present}</td>
                <td>${percent} %</td>
                <td>
                    <a class="btn" href="/student/${student.id}/attendance">View</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
