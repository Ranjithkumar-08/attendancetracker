 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student List</title>
    <link rel="icon" type="image/png" href="/img/TwinBird.png">
    <style>
        body {
            background: url('/img/classroom.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
        }

        .top-heading {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px 20px;
            font-size: 28px;
            color: #00b8ff;
            background-color: #000;
            border-radius: 5px;
            border-bottom: 1px solid #1a1a1a;
        }

        .top-heading b {
            text-align: center;
        }

        .top-heading .logout-btn, .top-heading .back-btn {
            position: absolute;
            padding: 10px 20px;
            background-color: #1DB954;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .top-heading .logout-btn {
            right: 20px;
        }

        .top-heading .back-btn {
            left: 20px;
        }

        .top-heading .logout-btn:hover, .top-heading .back-btn:hover {
            background-color: #17a74b;
        }

        table {
            width: 80%;
            margin: 40px auto;
            border-collapse: collapse;
            background: rgba(0, 0, 0, 0.85);
            box-shadow: 0 0 15px rgba(0, 184, 255, 0.3);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #333;
            text-align: center;
            font-size: 15px;
        }

        th {
            background: #00b8ff;
            color: #000;
        }

        tr:nth-child(even) {
            background-color: #1e1e1e;
        }

        tr:hover {
            background-color: #333;
        }

        td button {
            padding: 6px 12px;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            margin: 2px;
            font-size: 14px;
        }

        .update-btn {
            background-color: #ffa500;
        }

        .delete-btn {
            background-color: #ff4d4d;
        }

        .btn-attendance {
            background-color: #1DB954;
        }
        .view-btn{
        background-color: #17a74b;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 6px;
        }

        .add-btn {
            display: block;
            width: 220px;
            margin: 30px auto;
            padding: 12px;
            background: #00b8ff;
            color: #000;
            border-radius: 6px;
            text-align: center;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .add-btn:hover {
            background: #0092cc;
        }
    </style>
</head>
<body>

<div class="top-heading">
    <button class="back-btn" onclick="goBack()">Back</button>
    <b>Registered Students</b>
    <button class="logout-btn" onclick="logout()">Logout</button>
</div>

<table>
    <thead>
        <tr>
            <th>S.No</th>
            <th>ID</th>
            <th>Name</th>
            <th>Department</th>
            <th>Email</th>
            <th>Actions</th>
            <th>Stats</th>
        </tr>
    </thead>
    <tbody>
  <c:forEach var="student" items="${students}" varStatus="status">
    <c:if test="${not empty student.name}">
        <!-- Show row only if student has a name -->
        <tr>
            <td>${status.index + 1}</td>
            <td>${student.id}</td>
            <td>${student.name}</td>
            <td>${student.department}</td>
            <td>${student.email}</td>
            <td>
                <a href="/update/${student.id}"><button class="update-btn">Update</button></a>
                <a href="/delete/${student.id}"><button class="delete-btn">Delete</button></a>
            </td>
            <td>
                <a href="/${student.id}/attendance"><button class="view-btn">View Attendance</button></a>
            </td>
        </tr>
    </c:if>
</c:forEach>

    </tbody>
</table>

<a href="/registers" class="add-btn">Add New Student</a>

<script>
    function logout() {
        setTimeout(() => {
            window.location.href = "/logins";
        }, 100);
    }


    function goBack() {
        setTimeout(() => {
            window.location.href = "/registers";
        }, 100);
    }
</script>

</body>
</html>