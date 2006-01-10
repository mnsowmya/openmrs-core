<%@page isErrorPage="true" %>
<%@ page import="org.openmrs.web.WebConstants" %>
<%@ page import="org.openmrs.api.APIAuthenticationException" %>
<%@ include file="/WEB-INF/template/include.jsp" %>

<%@ include file="/WEB-INF/template/header.jsp" %>

&nbsp;<br />

<h2>An Internal Error has Occured</h2>

<style>
	#stackTrace {
		display: none;
		font-size: 11px;
		padding: 2px;
		width: 585px;
	}
</style>

<script>
	function showOrHide() {
		var link = document.getElementById("toggleLink");
		var trace = document.getElementById("stackTrace");
		if (link.innerHTML == "Show stack trace") {
			link.innerHTML = "Hide stack trace";
			trace.style.display = "block";
		}
		else {
			link.innerHTML = "Show stack trace";
			trace.style.display = "none";
		}
	}
</script>	

<% 
try {
	// The Servlet spec guarantees this attribute will be available
	//Throwable exception = (Throwable) request.getAttribute("javax.servlet.error.exception"); 

	out.println("<b>" + exception.getClass().getName() + "</b>");
	out.println(exception.getMessage()); 
	%>
	
	<br /><br />
	Consult the <a href="<%= request.getContextPath() %>/help.jsp">help document</a>. <br />
	Contact your friendly neighborhood administrator if it cannot be resolved.
	
	<br /><br />
	
	<a href="javascript:showOrHide()" id="toggleLink" style="font-size: 12px;">Show stack trace</a>
	<br />
	<div id="stackTrace">
	<%
	if (exception != null) {
		if (exception instanceof APIAuthenticationException) {
			// If they are not authorized to use a function
			session.setAttribute(WebConstants.OPENMRS_ERROR_ATTR, "auth.invalid");
			session.setAttribute(WebConstants.OPENMRS_LOGIN_REDIRECT_HTTPSESSION_ATTR, request.getAttribute("javax.servlet.error.request_uri"));
			response.sendRedirect("/@WEBAPP.NAME@/login.htm");
		}
		else if (exception instanceof ServletException) {
			// It's a ServletException: we should extract the root cause
			ServletException sEx = (ServletException) exception;
			Throwable rootCause = sEx.getRootCause();
			if (rootCause == null)
				rootCause = sEx;
			out.println("<br><br>** Root cause is: "+ rootCause.getMessage());
			rootCause.printStackTrace(new java.io.PrintWriter(out)); 
		}
		else {
			// It's not a ServletException, so we'll just show it
			exception.printStackTrace(new java.io.PrintWriter(out)); 
		}
	} 
	else  {
    	out.println("<br>No error information available");
	} 

	// Display cookies
	out.println("<br><br>Cookies:<br>");
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
    	for (int i = 0; i < cookies.length; i++) {
      		out.println(cookies[i].getName() + "=[" + cookies[i].getValue() + "]");
		}
	}
	    
} catch (Exception ex) { 
	ex.printStackTrace(new java.io.PrintWriter(out));
}
%>
		</div> <!-- close stack trace box -->
	</div> <!-- close box -->

<%@ include file="/WEB-INF/template/footer.jsp" %>