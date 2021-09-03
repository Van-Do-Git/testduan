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
            case "editday":
                break;
            case "editmonth":
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
            default:
                showExpenditure(request, response);
        }
    }

    private void showExpenditure(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("expenditure.jsp");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Date date = new Date();
        List<Expenditure> listMonth = expenditureService.findByMonth(date, user.getId());
        List<Category> listCategory = categoryExService.findByIdUser(user.getId());
        Limited limited = limitedService.findByIdUser(user.getId());
        request.setAttribute("listEx", listMonth);
        request.setAttribute("listCategory", listCategory);
        request.setAttribute("limited", limited);
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
