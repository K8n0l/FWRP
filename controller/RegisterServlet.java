package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import entity.User;
import service.UserService;
import service.impl.UserServiceImpl;
import util.UserType;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserService userService;
    @Override
    public void init() throws ServletException {
        super.init();
        this.userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userType = request.getParameter("userType");

        User newUser = new User();
        newUser.setUserName(request.getParameter("username"));
        newUser.setPassword(request.getParameter("password"));
        newUser.setEmail(request.getParameter("email"));
        newUser.setPhoneNumber(request.getParameter("phoneNumber"));

        if (userType != null && !userType.isEmpty()) {
            newUser.setUserType(UserType.valueOf(userType));
        } else {
            request.setAttribute("errorMessage", "Please select a user type.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        boolean registrationResult = userService.register(newUser);
        if (registrationResult) {
            request.setAttribute("successMessage", "Registration successful! You can now login.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "User already exists. Please try a different username.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }

    }
}
