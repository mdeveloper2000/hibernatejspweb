<%@page import="hibernatefundamentosweb.util.HibernateManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    <body>
        
        <%
            if(request.getParameter("id") != null) {
                int id = Integer.valueOf(request.getParameter("id"));
                HibernateManager manager = new HibernateManager();
                manager.delete(id);
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        %>
        
    </body>
    
</html>