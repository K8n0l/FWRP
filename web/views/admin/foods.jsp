<%@page import="java.util.List"%>
<%@page import="entity.Food"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Food Inventory List</title>
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
        td {
            vertical-align: top;
        }
        td.expiring {
            background-color: #DC143C;
        }
        p {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Food Inventory List</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Food Type</th>
                <th>Expiration</th>
                <th>Owner</th>
            </tr>
        </thead>
        <tbody>
            <% List<Food> foods = (List<Food>) request.getAttribute("foods");
               for (Food food : foods) {%>
            <tr>
                <td><%= food.getId()%></td>
                <td><%= food.getName()%></td>
                <td><%= food.getQuantity()%></td>
                <td><%= food.getPrice()%></td>
                <td><%= food.getFoodType().toString()%></td>
                <% if (food.getExpirationDate().getTime() < (new Date().getTime() + 7 * 24 * 60 * 60 * 1000)) { %>
                    <td class="expiring"><%= food.getExpirationDate()%></td>
                <% } else { %>
                    <td><%= food.getExpirationDate()%></td>
                <% } %>
                <td><%= food.getUserID()%></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <p>Back to &#128073; <a href="${pageContext.request.contextPath}/views/admin/admin_dashboard.jsp">Dashboard</a></p>
</body>
</html>
