<%@page import="entity.User"%>
<%@page import="util.UserType"%>
<%@page import="java.util.List"%>
<%@page import="entity.Subscription"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Subscription</title>
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
        .subscribe-form {
            margin-top: 20px;
        }
        .message {
            font-weight: bold;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>

<body>
    <div>
        <h2>Current subscriptions</h2>
        <table border="1">
            <tr>
                <th>Food Type</th>
                <th>Location</th>
                <th>Action</th>
            </tr>
            <%
                List<Subscription> subscriptions = (List<Subscription>) request.getAttribute("subscriptions");
                if (subscriptions != null) {
                    for (Subscription subscription : subscriptions) {
            %>
            <tr>
                <td><%= subscription.getPreferenceType().toString()%></td>
                <td><%= subscription.getRetailerUsername()%></td>
                <td>
                    <form action="unsubscribe.subdo" method="post">
                        <input type="hidden" name="selectOption" value="<%=subscription.getId()%>">
                        <button class="but" type="submit">Unsubscribe</button>
                    </form>
                </td>
            </tr>
            <% }
                }%>
        </table>

        <h2>Subscribe to Surplus Food Alerts</h2>
        <form class="subscribe-form" action="subscribe.subdo" method="post">
            <fieldset>
                <legend>Subscription Details</legend>
                <label for="preference">Food Preference:</label>
                <select name="preferenceType" id="preference" required>
                    <option value="DAIRY">Dairy</option>
                    <option value="PERISHABLE">Perishable</option>
                    <option value="CARBOHYDRATE">Carbohydrate</option>
                    <option value="DRINK">Drink</option>
                </select>
                <br><br>

                <label>Contact Type:</label>
                <input type="radio" id="email" name="contactType" value="EMAIL" required>
                <label for="email">Email</label>
                <input type="radio" id="text" name="contactType" value="TEXT" required>
                <label for="text">Text</label>
                <br><br>

                <label for="retailer_username">Location:</label>
                <select id="retailer_username" name="retailer_username" required>
                    <% List<User> retailers = (List<User>) request.getAttribute("retailers");
                        for (User retailer : retailers) {
                    %>
                    <option value="<%= retailer.getUserName()%>"><%= retailer.getUserName()%></option>
                    <% } %>
                </select>
                <br><br>

                <input type="submit" value="Subscribe" class="but">
            </fieldset>
        </form>

        <% if (request.getAttribute("errorMessage") != null) {%>
        <p class="message" style="color:red;"><%= request.getAttribute("errorMessage")%></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) {%>
        <p class="message" style="color:green;"><%= request.getAttribute("successMessage")%></p>
        <% }%>
    </div>

    <div>
        <%
            User user = (User) session.getAttribute("user");
            if (user != null) {
                if (user.getUserType() == UserType.CUSTOMER) {
        %>
        <p>Back to &#128073; <a href="${pageContext.request.contextPath}/ClientServlet">Dashboard</a></p>
        <% } else if (user.getUserType() == UserType.CHARITY) { %>
        <p>Back to &#128073; <a href="${pageContext.request.contextPath}/ShowDonationFoodsServlet">Dashboard</a></p>
        <% }
            } %>
    </div>
</body>
</html>
