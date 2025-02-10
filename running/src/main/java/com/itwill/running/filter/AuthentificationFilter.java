package com.itwill.running.filter;

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

import java.io.IOException;
import java.net.URLEncoder;

import javax.mail.Session;

/**
 * Servlet Filter implementation class AuthentificationFilter
 */
@Slf4j
@WebFilter("/AuthentificationFilter")
public class AuthentificationFilter extends HttpFilter implements Filter {

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
		String signedInUserId = (String) session.getAttribute("signedInUserId");
		
		log.debug("signedInUserId={}",signedInUserId);
		
		if (signedInUserId== "" || signedInUserId == null) {
			// 로그인이 되지 않은 유저
			String url = httpReq.getRequestURL().toString();
			String qs = httpReq.getQueryString();
			String target = null; // 로그인 성공후 이동할 주소
			if (qs != null) {
				// 쿼리스트링 존재
				target = URLEncoder.encode(url + "?" + qs, "UTF-8");
			} else {
				target = URLEncoder.encode(url, "UTF-8");
			}
			String signInPage = httpReq.getContextPath() + "/user/signin?target=" + target;
			httpRes.sendRedirect(signInPage);

		} else {
			Integer authCheck = (Integer) session.getAttribute("authCheck");
			log.debug("authCheck={}",authCheck);
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

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {

	}

}
