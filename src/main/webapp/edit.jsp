<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="hibernatefundamentos.pojos.Curso"%>
<%@page import="hibernatefundamentosweb.util.HibernateManager"%>
<%@page import="hibernatefundamentos.pojos.Estudante"%>
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
        <%! Estudante estudante = null; %>
        <%! List<Curso> cursos = null; %>
        <%
            if(request.getParameter("id") != null) {
                HibernateManager manager = new HibernateManager();
                int id = Integer.valueOf(request.getParameter("id"));
                estudante = manager.read(id);
                cursos = estudante.getCursos();
            }           
        %>
        
        <h2 class="text-center mt-5">Novo Estudante e Cursos</h2>
        <div class="container w-50 mt-5 align-middle">
            <form method="post">
                <label class="form-label">Nome do estudante:</label>
                <input type="text" class="form-control" name="nome" required onblur="this.value=this.value.trim().toUpperCase();" maxlength="50" value="<%=estudante.getNome()%>" />
                <label class="form-label">Curso (Pelo menos um curso deve ser preenchido):</label>
                <input type="text" class="form-control" name="titulo1" required onblur="this.value=this.value.trim().toUpperCase();" maxlength="20" value="<%=cursos.get(0).getTitulo()%>" />
                <label class="form-label">Curso:</label>
                <input type="text" class="form-control" name="titulo2" onblur="this.value=this.value.trim().toUpperCase();" maxlength="20" value="<%=(cursos.size()>1?cursos.get(1).getTitulo():"")%>" />
                <label class="form-label">Curso:</label>
                <input type="text" class="form-control" name="titulo3" onblur="this.value=this.value.trim().toUpperCase();" maxlength="20" value="<%=(cursos.size()>2?cursos.get(2).getTitulo():"")%>" />
                <button type="submit" class="btn btn-primary mt-3">Editar <i class="bi bi-pencil-square"></i></button>                
            </form>
            <hr />
            <div class="text-center">
                <a type="button" class="btn btn-success" href="index.jsp"><i class="bi bi-house-door-fill"></i></a>
            </div>
        </div>
                
    <%
        
        if(request.getParameter("nome") != null) {
            int id = Integer.valueOf(request.getParameter("id"));
            HibernateManager manager = new HibernateManager();
            Estudante estudante = new Estudante();
            estudante.setId(id);
            String nome = request.getParameter("nome");
            estudante.setNome(nome);
            String titulo1 = request.getParameter("titulo1");
            List<String> nomes = new ArrayList<>();
            nomes.add(titulo1);
            String titulo2 = request.getParameter("titulo2");
            String titulo3 = request.getParameter("titulo3");
            if(!titulo2.equals("")) {
                nomes.add(titulo2);
            }
            if(!titulo3.equals("")) {
                nomes.add(titulo3);
            }            
            List<Curso> cursos = new ArrayList<>();
            for(String n : nomes) {
                Curso c = new Curso();
                c.setTitulo(n);
                cursos.add(c);
            }
            estudante.setCursos(cursos);
            manager.update(estudante);
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        }
        
    %>
        
    </body>
    
</html>