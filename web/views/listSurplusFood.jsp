<%@page import="entity.Food"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="util.FoodType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>List Surplus Food</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 20px;
        }
        h2 {
            color: #333;
            text-align: center;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        form {
            margin-top: 20px;
            text-align: center;
        }
        button {
            padding: 10px 20px;
            font-size: 14px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        p {
            margin-top: 10px;
            text-align: center;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            text-decoration: none;
            color: #007bff;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
        .success-message {
            color: green;
            text-align: center;
            margin-top: 10px;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h2>List Surplus Food</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <% if (request.getAttribute("successMessage") != null) { %>
    <p class="success-message"><%= request.getAttribute("successMessage") %></p>
    <% } %>

    <% Food food = (Food) session.getAttribute("foodDetail"); %>
    <% DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy"); %>
    <% String expirationStr = dateFormat.format(food.getExpirationDate()); %>
    
    <table border="1">
        <tr>
            <th>ID</th>
            <td><%= food.getId() %></td>
        </tr>
        <tr>
            <th>Name</th>
            <td><%= food.getName() %></td>
        </tr>
        <tr>
            <th>Quantity</th>
            <td><%= food.getQuantity() %></td>
        </tr>
        <tr>
            <th>Price</th>
            <td><%= food.getPrice() %></td>
        </tr>
        <tr>
            <th>Food Type</th>
            <td><%= food.getFoodType().name() %></td>
        </tr>
        <tr>
            <th>Expiration</th>
            <td><%= expirationStr %></td>
        </tr>
    </table><br><br>

    <form action="listOneSurplusFood.do" method="post">
        <label for="discountRate">Discount Rate:</label>
        <input type="number" id="discountRate" name="discountRate" step="0.01" min="0" max="1"> <br><br>
        
        <input type="checkbox" id="donation" name="donation">
        <label for="donation">Is For Donation?</label><br><br>

        <button type="submit">List As Surplus Food</button>
    </form><br>

    <div class="back-link">
        <p>Back to &#128073; <a href="${pageContext.request.contextPath}/RetailerServlet">Dashboard</a></p>
    </div>
</body>
</html>
