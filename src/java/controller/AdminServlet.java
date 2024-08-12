package controller;

import entity.Food;
import entity.Subscription;
import entity.SurplusFood;
import entity.User;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.FoodService;
import service.SubscriptionService;
import service.SurplusFoodService;
import service.UserService;
import service.impl.FoodServiceImpl;
import service.impl.SubscriptionServiceImpl;
import service.impl.SurplusFoodServiceImpl;
import service.impl.UserServiceImpl;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet", "*.admindo"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = request.getRequestURI();

        String methodName = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
        Method method = null;
        try {
            method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, request, response);
        } catch (Exception e) {
            throw new RuntimeException("method error" + methodName, e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("username");
        String password = request.getParameter("password");

        if (userName.equals("admin") && password.equals("admin123")) {
            response.sendRedirect(request.getContextPath() + "/views/admin/admin_dashboard.jsp");
            return;
        }
        request.setAttribute("errorMessage", "login failed");
        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    private void getUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserService userservice = new UserServiceImpl();
        List<User> users = userservice.getAllUsers();
        request.setAttribute("users", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/users.jsp");
        dispatcher.forward(request, response);
    }

    private void getFoods(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FoodService foodservice = new FoodServiceImpl();
        List<Food> foods = foodservice.getAllFoods();
        request.setAttribute("foods", foods);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/foods.jsp");
        dispatcher.forward(request, response);
    }

    private void getSurplusFoods(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SurplusFoodService surplusFoodService = new SurplusFoodServiceImpl();
        List<SurplusFood> surplusfoods = surplusFoodService.getAllSurplusFood();;
        request.setAttribute("surplusfoods", surplusfoods);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/surplusfoods.jsp");
        dispatcher.forward(request, response);
    }

    private void getSubscriptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SubscriptionService subscriptionFoodService = new SubscriptionServiceImpl();
        List<Subscription> subscriptions = subscriptionFoodService.getAllSubscriptions();
        request.setAttribute("subscriptions", subscriptions);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/subscriptions.jsp");
        dispatcher.forward(request, response);
    }
}
