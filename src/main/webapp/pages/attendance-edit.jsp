<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Attendance Summary</title>
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

        form {
            margin: 40px auto;
            padding: 30px;
            width: 40%;
            background: rgba(0, 0, 0, 0.85);
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 184, 255, 0.3);
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 16px;
        }

        input {
            width: 100%;
            padding: 10px;
            background-color: #1e1e1e;
            color: white;
            border: 1px solid #444;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 16px;
        }

        button[type="submit"] {
            background-color: #00b8ff;
            color: white;
            border: none;
            padding: 12px 20px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        button[type="submit"]:hover {
            background-color: #0092cc;
        }
    </style>
</head>
<body>

<div class="header">Edit Attendance Summary - ${student.name} (ID: ${student.id})</div>

<div class="controls">
    <button onclick="goBack()">Back</button>
    <button onclick="logout()">Logout</button>
</div>

<form method="post" action="/attendance/student/${student.id}/update-summary">
    <label for="presentDays">Present Days</label>
    <input type="number" id="presentDays" name="presentDays" value="${presentDays}" required>

    <label for="totalDays">Total Days</label>
    <input type="number" id="totalDays" name="totalDays" value="${totalDays}" required>

    <label for="percentage">Attendance %</label>
    <input type="text" id="percentage" readonly>
    
    <button type="submit">Save Summary</button>
</form>


<script>
    function goBack() {
        window.location.href = "/lists";
    }

    function logout() {
        window.location.href = "/logins";
    }

    const presentInput = document.getElementById('presentDays');
    const totalInput = document.getElementById('totalDays');
    const percentInput = document.getElementById('percentage');

    function updatePercentage() {
        const present = parseInt(document.getElementById('presentDays').value) || 0;
        const total = parseInt(document.getElementById('totalDays').value) || 1;
        const percent = ((present / total) * 100).toFixed(2);
        document.getElementById('percentage').value = percent + "%";
    }

    document.getElementById('presentDays').addEventListener('input', updatePercentage);
    document.getElementById('totalDays').addEventListener('input', updatePercentage);

    // Initial calculation
    updatePercentage();
</script>

</body>
</html>
