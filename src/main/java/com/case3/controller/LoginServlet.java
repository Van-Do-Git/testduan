package com.case3.controller;

import com.case3.model.User;
import com.case3.service.user.UserService;
import com.case3.validate.Validate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

@WebServlet(name = "login", value = "/homepage")
public class LoginServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                break;
            default:
                showHomepage(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "login":
                login(request, response);
                break;
            case "signUp":
                singUp(request, response);
                break;
            default:
                showHomepage(request, response);
        }
    }

    private void singUp(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/homepage?action=&username=&password=");
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("userName");
        String phone = request.getParameter("phoneNumber");
        String password = request.getParameter("password");
        String role = "other";
        boolean status = true;
        User user = new User(fullName, phone, username, password, role, status);
        String message;
        Validate validate = Validate.getInstance();
        if (validate.validate(username, validate.regexUsername)
                && validate.validate(phone, validate.regexPhone)
                && validate.validate(password, validate.regexPassword)) {
            userService.save(user);
            message = "Dang ky thanh cong";
            request.setAttribute("message", message);
        } else {
            message = "Dang ky khong thanh cong, moi nhap lai";
            request.setAttribute("message", message);
            request.setAttribute("user", user);
        }
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String username = request.getParameter("userName");
        String password = request.getParameter("password");
        User user = userService.findByUsernameAndPassword(username, password);
        String destPage;
        if (user != null) {
            if (user.isStatus() && user.getRole().equals("other")) {
                HttpSession session = request.getSession();
                request.setAttribute("message", null);
                session.setAttribute("user", user);
                destPage = "/expenditure";
            } else if (user.isStatus() && user.getRole().equals("admin")) {
                HttpSession session = request.getSession();
                request.setAttribute("message", null);
                session.setAttribute("user", user);
                destPage = "/admin.jsp";
            } else {
                destPage = "/homepage?action=&username=&password=";
                request.setAttribute("message", "Tai khoan cua ban da bi khoa");
            }
        } else {
            destPage = "/homepage?action=&username=&password=";
            request.setAttribute("message", "Tai khoan khong dung, yeu cau dang nhap lai hoac dang ky");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void showHomepage(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");

        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
