<%@page import="entity.SurplusFood"%>
<%@page import="java.util.List"%>
<%@page import="entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consumer Dashboard</title>
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
    <h2>Consumer Dashboard</h2>

    <div>
        <% if (request.getAttribute("successCheckout") != null) {%>
        <p class="success-message"><%= request.getAttribute("successCheckout")%></p>
        <% }%>
        <% if (request.getAttribute("errorCheckout") != null) {%>
        <p class="error-message"><%= request.getAttribute("errorCheckout")%></p>
        <% } %>   
        <% if (request.getAttribute("notifications") != null) {
                List<String> notifications = (List<String>) request.getAttribute("notifications");
                for (String notification : notifications) {
        %>
        <p class="info-message"><%= notification%></p>
        <% }
            }%> 
        <h2>Purchase Discounted Items</h2>
        <table>
            <thead>
                <tr>
                    <th>Select Quantity</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Food Type</th>
                    <th>Expiration</th>
                </tr>
            </thead>
            <tbody>
                <% List<SurplusFood> foodList = (List<SurplusFood>) request.getAttribute("surplusFood");
                    if (foodList != null) {
                        for (SurplusFood food : foodList) {%>
                <tr>
                    <td>
                        <form action="${pageContext.request.contextPath}/PurchaseSurplusServlet" method="post">
                            <input type="hidden" name="foodID" value="<%= food.getId()%>">
                            <input type="number" name="quantity" value="0" min="0" max="<%= food.getQuantity()%>">
                            <button type="submit">Check out</button>
                        </form>
                    </td>
                    <td><%= food.getName()%></td>
                    <td><%= food.getQuantity()%></td>
                    <td><%= food.getPrice()%></td>
                    <td><%= food.getFoodType().name()%></td>
                    <td><%= food.getExpirationDate()%></td>
                </tr>
                <% }
                    } else {
                %>
                <tr>
                    <td colspan="6" class="info-message">No items available for purchase.</td>
                </tr>
                <% } %>
            </tbody>
        </table>  
    </div><br><br>

    <div>
        <form action="${pageContext.request.contextPath}/SubscribeServlet" method="get">
            <button type="submit">&#128276; Subscribe to Alerts &#128276;</button>
        </form>
    </div><br>

    <div>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button type="submit">&#128075; Log out</button>
        </form>
    </div>
</body> 
</html>
