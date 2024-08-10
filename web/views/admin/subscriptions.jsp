<%@page import="entity.Subscription"%>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subscriptions List</title>
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
    <h2>Subscriptions List</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>User ID</th>
                <th>Contact Type</th>
                <th>Preference Type</th>
                <th>Retailer Name</th>
            </tr>
        </thead>
        <tbody>
            <% List<Subscription> subscriptions = (List<Subscription>) request.getAttribute("subscriptions");
               for (Subscription subscription : subscriptions) {%>
            <tr>
                <td><%= subscription.getId()%></td>
                <td><%= subscription.getUserID()%></td>
                <td><%= subscription.getContactType().toString()%></td>
                <td><%= subscription.getPreferenceType().toString()%></td>
                <td><%= subscription.getRetailerUsername()%></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <p>Back to &#128073; <a href="${pageContext.request.contextPath}/views/admin/admin_dashboard.jsp">Dashboard</a></p>
</body>
</html>
