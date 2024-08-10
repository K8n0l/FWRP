<%@page import="entity.SurplusFood"%>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Surplusfood Inventory List</title>
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
    <h2>Surplusfood Inventory List</h2>

    <table>
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
            </tr>
        </thead>
        <tbody>
            <% List<SurplusFood> surplusfoods = (List<SurplusFood>) request.getAttribute("surplusfoods");
               for (SurplusFood surplusfood : surplusfoods) {%>
            <tr>
                <td><%= surplusfood.getId()%></td>
                <td><%= surplusfood.getName()%></td>
                <td><%= surplusfood.getQuantity()%></td>
                <td><%= surplusfood.getPrice()%></td>
                <td><%= surplusfood.getFoodType().toString()%></td>
                <td><%= surplusfood.getExpirationDate()%></td>
                <td><%= surplusfood.getDiscountRate()%></td>
                <td>
                    <input type="checkbox" id="donation" name="donation" onclick="return false;"
                           <% if (surplusfood.isIsForDonation()) { %>
                               checked
                           <% } %>
                    />
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <p>Back to &#128073; <a href="${pageContext.request.contextPath}/views/admin/admin_dashboard.jsp">Dashboard</a></p>
</body>
</html>
