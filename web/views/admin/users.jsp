<%@page import="entity.User"%>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        h2 {
            color: darkblue;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        p {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>User List</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Password</th>
                <th>User Type</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Is Subscribed</th>
            </tr>
        </thead>
        <tbody>
            <% List<User> users = (List<User>) request.getAttribute("users");
               for (User user : users) {%>
            <tr>
                <td><%= user.getId()%></td>
                <td><%= user.getUserName()%></td>
                <td><%= user.getPassword()%></td>
                <td><%= user.getUserType().toString()%></td>
                <td><%= user.getPhoneNumber()%></td>
                <td><%= user.getEmail()%></td>
                <td><%= user.isSubscribed()%></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <p>Back to &#128073; <a href="${pageContext.request.contextPath}/views/admin/admin_dashboard.jsp">Dashboard</a></p>
</body>
</html>
