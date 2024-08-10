<%@page import="java.util.List" %>
<%@page import="entity.Food" %>
<%@page import="entity.SurplusFood" %>
<%@page import="entity.User"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Retailer Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 20px;
        }
        h2, h3 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        td {
            vertical-align: middle;
        }
        .add-form {
            margin-bottom: 20px;
        }
        .add-form input[type="text"], 
        .add-form input[type="number"], 
        .add-form select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .add-form button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .add-form button:hover {
            background-color: #45a049;
        }
        .status-urgent {
            background-color: #DC143C;
            color: white;
        }
        .action-buttons {
            display: flex;
            justify-content: space-around;
        }
        .but {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .but:hover {
            background-color: #0056b3;
        }
        .checkbox-label {
            display: block;
            margin-top: 8px;
        }
        .report-button {
            margin-top: 10px;
            padding: 8px 16px;
            background-color: #ffc107;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .report-button:hover {
            background-color: #e0a800;
        }
        .logout-button {
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .logout-button:hover {
            background-color: #c82333;
        }
        .message {
            margin-top: 10px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>Welcome, <%= ((User) session.getAttribute("user")).getUserName()%>!</h2>
    <h3 style="color: darkblue;"><i>Retailer Dashboard</i></h3>

    <div>
        <h3>Manage Inventory</h3>
        <% if (request.getAttribute("errorMessage") != null) {%>
        <p class="message" style="color:red;"><%= request.getAttribute("errorMessage")%></p>
        <% } %>

        <% if (request.getAttribute("successMessage") != null) {%>
        <p class="message" style="color:green;"><%= request.getAttribute("successMessage")%></p>
        <% }%>

        <% if (request.getAttribute("errorMessage") != null) {%>
            <p style="color:red;"><%= request.getAttribute("errorMessage")%></p>
            <% } %>

            <% if (request.getAttribute("successMessage") != null) {%>
            <p style="color:green;"><%= request.getAttribute("successMessage")%></p>
            <% }%>
            <% List<Food> foodsInventory = (List<Food>) request.getAttribute("foodsInventory"); %>
            <br>
        <div class="add-form">
            <form action="addFood.do" id="addFoodForm" method="POST">
                <table>
                    <tr>
                        <td><input type="text" name="name" placeholder="Name" required></td>
                        <td><input type="number" name="quantity" placeholder="Quantity" required></td>
                        <td><input type="number" name="price" step="0.01" placeholder="Price" required></td>
                        <td>
                            <select name="foodType" id="foodType" required>
                                <option value="DAIRY">DAIRY</option>
                                <option value="PERISHABLE">PERISHABLE</option>
                                <option value="CARBOHYDRATE">CARBOHYDRATE</option>
                                <option value="DRINK">DRINK</option>
                            </select>
                        </td>
                        <td><input type="text" name="expiration" id="datepicker" placeholder="Expiration" required></td>
                        <td><button class="but" type="submit">Add item</button></td>
                    </tr>
                </table>
            </form>
            <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
            <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
            <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
            <script>
                $(function() {
                    $("#datepicker").datepicker();
                });
            </script>
        </div>

        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Food Type</th>
                    <th>Expiration</th>
                    <th colspan="3">Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Food food : foodsInventory) {%>
                <tr>
                    <td><%= food.getId()%></td>
                    <td><%= food.getName()%></td>
                    <td><%= food.getQuantity()%></td>
                    <td>$ <%= food.getPrice()%></td>
                    <td><%= food.getFoodType().toString()%></td>
                    <td class="<%= food.getExpirationDate().getTime() < (new Date().getTime() + 7 * 24 * 60 * 60 * 1000) ? "status-urgent" : "" %>"><%= food.getExpirationDate()%></td>
                    <td>
                        <form action="getFoodDetail.do" method="post">
                            <input type="hidden" name="selectOption" value="<%=food.getId()%>">
                            <input type="hidden" name="updateFlag" value="1"> 
                            <button class="but" type="submit">Update</button>
                        </form>
                    </td>
                    <td>
                        <form action="getFoodDetail.do" method="post">
                            <input type="hidden" name="selectOption" value="<%=food.getId()%>">
                            <input type="hidden" name="updateFlag" value="0"> 
                            <button class="but" type="submit">Surplus</button>
                        </form>
                    </td>
                    <td>
                        <form action="deleteFood.do" method="post">
                            <input type="hidden" name="selectOption" value="<%=food.getId()%>">
                            <button class="but" type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
                <% }%>
            </tbody>
        </table>
    </div>

    <div>
        <h3>List Surplus Food Items</h3>
        
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Food Type</th>
                    <th>Expiration</th>
                    <th>Discount Rate</th>
                    <th>Donation</th>
                    <th colspan="3">Actions</th>
                </tr>
            </thead>
            <tbody>
                
                <% List<SurplusFood> surplusfoods = (List<SurplusFood>) request.getAttribute("surplusfoods");
for (SurplusFood surplusfood : surplusfoods) {%>
                <tr>
                    <td><%= surplusfood.getId()%></td>
                    <td><%= surplusfood.getName()%></td>
                    <td><%= surplusfood.getQuantity()%></td>
                    <td>$ <%= surplusfood.getPrice()%></td>
                    <td><%= surplusfood.getFoodType().toString()%></td>
                    <td><%= surplusfood.getExpirationDate()%></td>
                    <td><%= surplusfood.getDiscountRate()%></td>
                    <td><input type="checkbox" id="donation" name="donation" <% if (surplusfood.isIsForDonation()) { %> checked <% } %> disabled></td>
                    <td>
                        <form action="getSurplusFoodDetail.do" method="post">
                            <input type="hidden" name="selectOption" value="<%=surplusfood.getId()%>">
                            <button class="but" type="submit">Update</button>
                        </form>
                    </td>
                    <td>
                        <form action="unSurplusFood.do" method="post">
                            <input type="hidden" name="selectOption" value="<%=surplusfood.getId()%>">
                            <button class="but" type="submit">Unsurplus</button>
                        </form>
                    </td>
                    <td>
                        <form action="deleteSurplusFood.do" method="post">
                            <input type="hidden" name="selectOption" value="<%=surplusfood.getId()%>">
                            <button class="but" type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
                <% }%>
            </tbody>
        </table>
        
        <form action="report.do" method="post">
            <input type="hidden" name="retailer" value="<%= ((User) session.getAttribute("user")).getUserName()%>">
            <% for (SurplusFood surplusfood : surplusfoods) {%>
            <input type="hidden" name="selectOption" value="<%= surplusfood.getId()%>">
            <% } %>
            <button class="report-button" type="submit">Save All Surplus Food Reports</button>
        </form>

        <% if (request.getAttribute("errorReportMessage") != null) {%>
        <p class="message" style="color:red;"><%= request.getAttribute("errorReportMessage")%></p>
        <% } %>

        <% if (request.getAttribute("successReportMessage") != null) {%>
        <p class="message" style="color:green;"><%= request.getAttribute("successReportMessage")%></p>
        <% }%>

        <% if (request.getAttribute("locationMessage") != null) {%>
        <p class="message" style="color:green;"><%= request.getAttribute("locationMessage")%></p>
        <% }%>
    </div>

    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button class="logout-button" type="submit">&#128075; Log out</button>
    </form>

</body>
</html>
