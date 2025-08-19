<%
    session.invalidate();
    response.sendRedirect(request.getContextPath()+"/jsp/shared/login.jsp");
%>
