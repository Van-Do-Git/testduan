package com.case3.controller;

import com.case3.model.Category;
import com.case3.model.Expenditure;
import com.case3.model.Limited;
import com.case3.model.User;
import com.case3.service.category.CategoryExService;
import com.case3.service.limited.LimitedService;
import com.case3.service.ren_exp.ExpenditureService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ExpenditureServlet", value = "/expenditure")
public class ExpenditureServlet extends HttpServlet {
    ExpenditureService expenditureService = new ExpenditureService();
    CategoryExService categoryExService = new CategoryExService();
    LimitedService limitedService = new LimitedService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "logout":
                session.removeAttribute("user");
                response.sendRedirect("/expenditure?action=");
                break;
            case "addexp":
                response.sendRedirect("/addexp.jsp");
                break;
            case "editexp":
                showFormEditExpenditure(request, response);
                break;
            default:
                if (session.getAttribute("user") == null) {
                    response.sendRedirect("/homepage");
                } else {
                    showExpenditure(request, response);
                }
                break;

        }
    }

    private void showFormEditExpenditure(HttpServletRequest request, HttpServletResponse response) {
        int id_ex = Integer.parseInt(request.getParameter("idexp"));
        Expenditure expenditure = expenditureService.findById(id_ex);
        request.setAttribute("ex", expenditure);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/editexp.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "day":
                break;
            case "week":
                break;
            case "month":
                break;
            case "editday":
                editLimitDay(request, response);
                break;
            case "editmonth":
                editLimitMonth(request, response);
                break;
            case "editexp":
                editExpenditure(request, response);
                break;
            case "addexp":
                addNewExpenditure(request, response);
                break;
            default:
                showExpenditure(request, response);
        }
    }

    private void editLimitMonth(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int id_user = user.getId();
        int limitmonth = Integer.parseInt(request.getParameter("limitmonth"));
        limitedService.upateLimitMonth(id_user, limitmonth);
        try {
            response.sendRedirect("/expenditure?action=");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void editLimitDay(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int id_user = user.getId();
        int limitday = Integer.parseInt(request.getParameter("limitday"));
        limitedService.upateLimitDay(id_user, limitday);
        try {
            response.sendRedirect("/expenditure?action=");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void editExpenditure(HttpServletRequest request, HttpServletResponse response) {
        Date date = new Date();
        int money = Integer.parseInt(request.getParameter("money"));
        String note = request.getParameter("note");
        int id_exp = Integer.parseInt(request.getParameter("idexp"));
        int id_category = Integer.parseInt(request.getParameter("id"));
        Category category = categoryExService.findById(id_category);
        Expenditure expenditure = new Expenditure(category, date, money, note);
        expenditureService.edit(expenditure, id_exp);
        try {
            response.sendRedirect("/expenditure?action=");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void addNewExpenditure(HttpServletRequest request, HttpServletResponse response) {
        Date date = new Date();
        int money = Integer.parseInt(request.getParameter("money"));
        String note = request.getParameter("note");
        int id_category = Integer.parseInt(request.getParameter("id"));
        Category category = categoryExService.findById(id_category);
        Expenditure expenditure = new Expenditure(category, date, money, note);
        expenditureService.save(expenditure);
        try {
            response.sendRedirect("/expenditure?action=");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void showExpenditure(HttpServletRequest request, HttpServletResponse response) {
        Date date = new Date();
        SimpleDateFormat format =
                new SimpleDateFormat("yyyy.MM.dd");
        String dateString = format.format(date);
        Date dateNow = null;
        try {
            dateNow = format.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        request.setAttribute("dateNow", dateNow);
        RequestDispatcher dispatcher = request.getRequestDispatcher("expenditure.jsp");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");


        List<Expenditure> listMonth = expenditureService.findByMonth(date, user.getId());
        List<Category> listCategory = categoryExService.findByIdUser(user.getId());
        Limited limited = limitedService.findByIdUser(user.getId());
        request.setAttribute("listEx", listMonth);
        session.setAttribute("listCategory", listCategory);
        session.setAttribute("limited", limited);
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
