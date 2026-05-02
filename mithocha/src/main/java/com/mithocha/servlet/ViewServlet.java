package com.mithocha.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/*")
public class ViewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo(); // e.g. "/dashboard", "/analytics"

        if (path == null || "/".equals(path)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // Map URL path → JSP file
        String jspPage;
        switch (path) {
            case "/dashboard":  jspPage = "admin-dashboard.jsp";    break;
            case "/menu":       jspPage = "menumanagement.jsp";     break;
            case "/orders":     jspPage = "ordermanagement.jsp";    break;
            case "/customers":  jspPage = "customermanagement.jsp"; break;
            case "/inventory":  jspPage = "inventory.jsp";          break;
            case "/offers":     jspPage = "offerdiscount.jsp";      break;
            case "/analytics":  jspPage = "reportanlytics.jsp";     break;
            case "/billing":    jspPage = "billing.jsp";            break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Page not found: " + path);
                return;
        }

        // Forward to the correct JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/" + jspPage)
                .forward(request, response);
    }
}