package com.mithocha.servlet;

import com.mithocha.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * ContactServlet – serves the Contact Us page and handles form submission.
 *
 * URL mappings:
 *   GET  /contact  → show contact page
 *   POST /contact  → process contact form (logs message; extend to email/DB as needed)
 *
 * ── Frontend form mapping ──────────────────────────────────────────────────
 *   <form method="post" action="${pageContext.request.contextPath}/contact">
 *     <input  name="name"    ...>  → request.getParameter("name")
 *     <input  name="email"   ...>  → request.getParameter("email")
 *     <select name="subject" ...>  → request.getParameter("subject")
 *     <textarea name="message" ...> → request.getParameter("message")
 *   </form>
 */
@WebServlet(urlPatterns = {"/contact", "/about", "/blog"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/about".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/views/user/about.jsp")
                   .forward(request, response);
        } else if ("/blog".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/views/user/blog.jsp")
                   .forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/user/contact.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Basic validation
        if (ValidationUtil.isNullOrEmpty(name) || !ValidationUtil.isValidEmail(email)
                || ValidationUtil.isNullOrEmpty(message)) {
            request.setAttribute("errorMessage", "Please fill in all required fields with valid information.");
            request.getRequestDispatcher("/WEB-INF/views/user/contact.jsp")
                   .forward(request, response);
            return;
        }

        // Log the message (extend: save to DB or send email)
        System.out.printf("[ContactForm] From: %s <%s> | Subject: %s | Message: %s%n",
                name, email, subject, message);

        // Redirect with success flag
        response.sendRedirect(request.getContextPath() + "/contact?sent=true");
    }
}
