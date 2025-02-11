package com.itwill.running.filter;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

/**
 * Servlet Filter implementation class AuthentificationFilter
 */
@Slf4j
@WebFilter("/AuthentificationFilter")
public class AuthentificationFilter extends HttpFilter implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public AuthentificationFilter() {

	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {

	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpServletResponse httpRes = (HttpServletResponse) response;

		HttpSession session = httpReq.getSession();
		Integer authCheck = (Integer) session.getAttribute("authCheck");
		
		log.debug("authCheck={}", authCheck);
		if (authCheck == 1) {
			// 이메일 인증이 완료된 유저
			log.debug("인증완료");
			chain.doFilter(request, response);
			return;

		} else {
			// 이메일 인증이 되지 않은 유저
			log.debug("인증전");
			String authCheckFailedPage = httpReq.getContextPath() + "/authcheck/failed";
			httpRes.sendRedirect(authCheckFailedPage);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {

	}

}
