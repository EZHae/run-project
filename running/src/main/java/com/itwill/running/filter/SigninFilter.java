package com.itwill.running.filter;

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

/**
 * Servlet Filter implementation class SigninFilter
 */
@Slf4j
@WebFilter(filterName = "signinFilter", urlPatterns = { "/signinFilter" })
public class SigninFilter extends HttpFilter {
       
    /**
	 * 
	 */
	private static final long serialVersionUID = -636576312423563946L;

	/**
     * @see HttpFilter#HttpFilter()
     */
    public SigninFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		
		Object signedInUserId = session.getAttribute("signedInUserId");
		
		if (signedInUserId != null && !signedInUserId.equals("")) { // 로그인이 되어 있는 상태.
			log.debug("로그인 상태: signedInUserId={}", signedInUserId);
			
			// 필터 체인의 다음 단계(다음 필터 또는 서블릿)으로 request를 전달.
			chain.doFilter(request, response);
			return;
		} else {
			// 로그인 이후에 최초로 요청 주소로 이동(redirect) 하기 위해서
			log.debug("비로그인 상태");
			String url = req.getRequestURL().toString();
			String qs = req.getQueryString();
			String target = null;
			
			if (qs == null) {
				target = URLEncoder.encode(url, "UTF-8");
			} else {
				target = URLEncoder.encode(url + "?" + qs, "UTF-8");
			}
			log.debug("target={}", target);
			
			String signInPage = req.getContextPath() + "/user/signin?target=" + target;
			
			resp.sendRedirect(signInPage);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
