<%@page import="java.util.ListIterator"%>
<%@page import="hibernatefundamentosweb.util.HibernateManager"%>
<%@page import="hibernatefundamentos.pojos.Curso"%>
<%@page import="hibernatefundamentos.pojos.Estudante"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <title>JSP Page</title>
    </head>
    
    <body>
        
        <div class="container">
        
        <%! HibernateManager manager = null; %>
        <%! List<Estudante> estudantes = null; %>
        <%! long count = 0; %>
        
        <%
            if(manager == null) {
                manager = new HibernateManager();
            }            
            if(request.getParameter("search") == null) {                
                estudantes = manager.readAll();
                count = manager.getMax("");
            }
            else {
                estudantes = manager.search(request.getParameter("search"));
                count = manager.getMax(request.getParameter("search"));
            }
        %>
        
        <div>
            <a type="button" class="btn btn-primary mt-3" href="save.jsp">
                Cadastrar Estudante <i class="bi bi-person-plus-fill"></i>
            </a>
            <a type="button" class="btn btn-success mt-3 float-end" href="index.jsp">
                <i class="bi bi-arrow-clockwise"></i>
            </a>
        </div>
        <hr />
        
        <form>
        <div class="input-group mb-3 w-50 float-end">            
                <input type="text" class="form-control" name="search" 
                   placeholder="Pesquisar por nome" required onblur="this.value=this.value.trim().toUpperCase();" />
                <button type="submit" class="btn btn-primary">
                    Pesquisar <i class="bi bi-search"></i>
                </button>
            
        </div>
        </form>
        
            <table class="table table-striped">
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th colspan="3">Ações</th>
                </tr>
            <%
            for(Estudante e : estudantes) {
                out.print("<tr>");
                out.print("<td>"+e.getId()+"</td>");
                out.print("<td>"+e.getNome()+"</td>");
                out.print("<td>"+"<a class='btn btn-danger' href="+"delete.jsp?id="+e.getId()+">Deletar <i class='bi bi-trash3-fill'></i></a>"+"</td>");
                out.print("<td>"+"<a class='btn btn-success' href="+"read.jsp?id="+e.getId()+">Ver Cursos <i class='bi bi-person-lines-fill'></i></a>"+"</td>");
                out.print("<td>"+"<a class='btn btn-warning' href="+"edit.jsp?id="+e.getId()+">Editar <i class='bi bi-pencil-square'></i></a>"+"</td>");
                out.print("</tr>");
            }
            %>
        </table>
        
        <%
            if(estudantes.size() == 0) {
                out.println("<div class='alert alert-danger text-end'>Não registros na tabela ou a pesquisa não retornou resultados</div>");
            }
            else {
                HibernateManager hm = new HibernateManager();
                out.println("<div class='alert alert-info text-end'>"+count+" registro(s) encontrado(s)</div>");
            }
        %>    
        
        </div>
        
    </body>
    
</html>