<%@page import="entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user != null) {
            out.println("<h2>Welcome, " + user.getUserName() + "!</h2>");
            switch(user.getUserType()) {
                case RETAIL:
                    response.sendRedirect("../RetailerServlet");
                    break;
                case CUSTOMER:
                    response.sendRedirect("../ClientServlet"); 
                    break;
                case CHARITY:
                    response.sendRedirect("../ShowDonationFoodsServlet");
                    break;
                default:
                    out.println("<p>Unrecognized user type. Please <a href=\"../index.jsp\">log in</a> again.</p>");
                    break;
            }
        } else {
            // User not logged in or session expired
            out.println("<p>Please <a href=\"../index.jsp\">log in</a>.</p>");
        }
    %>
    
</body>
</html>
