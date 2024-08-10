<%@page import="entity.SurplusFood"%>
<%@page import="java.util.List"%>
<%@page import="entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Charity Dashboard</title>
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
        .success-message {
            color: green;
        }
        .error-message {
            color: red;
        }
        .info-message {
            color: blue;
        }
        .no-foods-message {
            font-style: italic;
            color: #888888;
        }
        form {
            margin-top: 10px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Welcome, <%= ((User) session.getAttribute("user")).getUserName()%>!</h2>
    <h2>Charity Dashboard</h2>

    <div>
        <% if (request.getAttribute("claimSuccess") != null) {%>
        <p class="success-message"><%= request.getAttribute("claimSuccess")%></p>
        <% } %>
        <% if (request.getAttribute("claimError") != null) {%>
        <p class="error-message"><%= request.getAttribute("claimError")%></p>
        <% } %>
        <% if (request.getAttribute("notifications") != null) {
                List<String> notifications = (List<String>) request.getAttribute("notifications");
                for (String notification : notifications) {
        %>
        <p class="info-message"><%= notification%></p>
        <% }
            }%> 
        <h2>Request Food Donations</h2>

        <table>
            <thead>
                <tr>
                    <th>Donatable Food</th>
                    <th>Available Quantity</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% List<SurplusFood> foodsForDonation = (List<SurplusFood>) request.getAttribute("foodsForDonation");
                    if (foodsForDonation != null && !foodsForDonation.isEmpty()) {
                        for (SurplusFood food : foodsForDonation) {
                %>
                <tr>
                    <td><%= food.getName()%></td>
                    <td><%= food.getQuantity()%></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/ClaimFoodServlet" method="post">
                            <input type="hidden" name="foodId" value="<%= food.getId()%>">
                            <input type="number" name="quantity" value="1" min="1" max="<%= food.getQuantity()%>">
                            <button type="submit">Claim</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="3" class="no-foods-message">No foods available for donation.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    <div>
        <form action="${pageContext.request.contextPath}/SubscribeServlet" method="get">
            <button type="submit">&#128276; Subscribe to Alerts &#128276;</button>
        </form>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit">&#128075; Log out</button>
    </form>
</body>
</html>
