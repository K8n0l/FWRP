<%@page import="entity.SurplusFood"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="util.FoodType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Surplus Food</title>
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
    <h2>Update Surplus Food Item</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <% if (request.getAttribute("successMessage") != null) { %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
    <% } %>

    <% SurplusFood surplusfood = (SurplusFood) session.getAttribute("foodDetail"); %>

    <form action="updateSurplusFood.do" method="post">
        <fieldset>
            <legend>Surplus Food Details</legend>

            <label for="id">ID:</label>
            <input type="text" id="id" name="id" readonly value="<%= surplusfood.getId() %>"><br>

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required readonly value="<%= surplusfood.getName() %>"><br>

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" readonly required value="<%= surplusfood.getQuantity() %>"><br>

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" readonly required value="<%= surplusfood.getPrice() %>"><br>

            <label for="foodType">Food Type:</label>
            <select id="foodType" name="foodType" readonly>
                <option value="DAIRY" <%= surplusfood.getFoodType() == FoodType.DAIRY ? "selected" : "" %>>DAIRY</option>
                <option value="PERISHABLE" <%= surplusfood.getFoodType() == FoodType.PERISHABLE ? "selected" : "" %>>PERISHABLE</option>
                <option value="CARBOHYDRATE" <%= surplusfood.getFoodType() == FoodType.CARBOHYDRATE ? "selected" : "" %>>CARBOHYDRATE</option>
                <option value="DRINK" <%= surplusfood.getFoodType() == FoodType.DRINK ? "selected" : "" %>>DRINK</option>
            </select><br>

            <label for="expiration">Expiration:</label>
            <input type="text" id="datepicker" name="expiration" value="<%= expirationStr %>" readonly><br>

            <label for="discountRate">Discount Rate:</label>
            <input type="number" id="discountRate" name="discountRate" step="0.01" min="0" max="1" value="<%= surplusfood.getDiscountRate() %>"><br>

            <input type="checkbox" id="donation" name="donation" <%= surplusfood.isIsForDonation() ? "checked" : "" %>>
            <label for="donation">Is For Donation?</label><br>

            <button class="but" type="submit">Update</button>
        </fieldset>
    </form>

    <div class="back-link">
        <p>Back to &#128073; <a href="${pageContext.request.contextPath}/RetailerServlet">Dashboard</a></p>
    </div>
</body>
</html>
