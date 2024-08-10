<%@page import="entity.Food"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="util.FoodType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update food</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
        form {
            max-width: 600px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-bottom: 8px;
        }
        input, select {
            width: calc(100% - 10px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        #datepicker {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .but {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .but:hover {
            background-color: #0056b3;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(document).ready(function() {
            $("#datepicker").datepicker({
                dateFormat: 'mm/dd/yy'
            });
        });
    </script>
</head>
<body>
    <h2>Update Food Item</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <% if (request.getAttribute("successMessage") != null) { %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
    <% } %>

    <%
        Food food = (Food) session.getAttribute("foodDetail");
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String expirationStr = dateFormat.format(food.getExpirationDate());
    %>

    <form action="updateFood.do" method="post">
        <fieldset>
            <legend>Food Details</legend>
            <label for="id">ID:</label>
            <input type="text" id="id" name="id" readonly value="<%= food.getId() %>"><br>

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required value="<%= food.getName() %>"><br>

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" required value="<%= food.getQuantity() %>"><br>

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" required value="<%= food.getPrice() %>"><br>

            <label for="foodType">Food Type:</label>
            <select id="foodType" name="foodType">
                <option value="DAIRY" <%= food.getFoodType() == FoodType.DAIRY ? "selected" : "" %>>DAIRY</option>
                <option value="PERISHABLE" <%= food.getFoodType() == FoodType.PERISHABLE ? "selected" : "" %>>PERISHABLE</option>
                <option value="CARBOHYDRATE" <%= food.getFoodType() == FoodType.CARBOHYDRATE ? "selected" : "" %>>CARBOHYDRATE</option>
                <option value="DRINK" <%= food.getFoodType() == FoodType.DRINK ? "selected" : "" %>>DRINK</option>
            </select><br>

            <label for="expiration">Expiration:</label>
            <input type="text" id="datepicker" name="expiration" value="<%= expirationStr %>"><br>

            <button class="but" type="submit">Update</button>
        </fieldset>
    </form>

    <div class="back-link">
        <p>Back to &#128073; <a href="${pageContext.request.contextPath}/RetailerServlet">Dashboard</a></p>
    </div>
</body>
</html>
