<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Portal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 40px;
        }
        h2 {
            color: darkblue;
            font-style: italic;
        }
        .menu-item {
            margin-top: 20px;
        }
        .menu-item a {
            display: block;
            padding: 10px 20px;
            background-color: #ffffff;
            border: 1px solid #cccccc;
            text-decoration: none;
            color: #333333;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .menu-item a:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <h2>Admin Dashboard</h2>
    
    <div class="menu-item"><a href="getUsers.admindo">Users</a></div>
    <div class="menu-item"><a href="getFoods.admindo">Foods</a></div>
    <div class="menu-item"><a href="getSurplusFoods.admindo">Surplus Foods</a></div>
    <div class="menu-item"><a href="getSubscriptions.admindo">Subscriptions</a></div>

</body>
</html>
