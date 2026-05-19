package com.mithocha.filter;

import com.mithocha.exception.ApiException;
import com.mithocha.util.ApiResponseUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/api/*")
public class ApiExceptionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        try {
            chain.doFilter(request, response);
        } catch (ApiException ex) {
            if (!httpResponse.isCommitted()) {
                ApiResponseUtil.writeError(httpResponse, ex.getStatusCode(), ex.getMessage());
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            if (!httpResponse.isCommitted()) {
                ApiResponseUtil.writeError(httpResponse, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "An unexpected server error occurred.");
            }
        }
    }

    @Override public void init(FilterConfig filterConfig) {}
    @Override public void destroy() {}
}
