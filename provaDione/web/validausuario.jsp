<%-- 
    Document   : validausuario
    Created on : 15/06/2018, 16:26:26
    Author     : felipe
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Acessar Sistema</title>
    </head>
    <body>
        <%
              Connection conectar=null;
              try{
                   Class.forName("com.mysql.jdbc.Driver");
                   String user="root";
                   String password="";
                   String url="jdbc:mysql://localhost/prova_dione";
                   conectar=DriverManager.getConnection(url, user, password);
              }catch(ClassNotFoundException clex){
                  out.println("Erro ao carregar o driver do MySQL:"+clex);
              }catch(SQLException sqlex){
                  out.println("Erro ao acessar o banco de dados:"+sqlex);
              }catch(Exception ex){
                  out.println("Erro:"+ex);
              }
              String user=request.getParameter("user");
              String password=request.getParameter("password");
              Statement acessar=null;
              try{
                  acessar=conectar.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                  String sql="select count(*) as valor from user where usuario='"+user+"' and senha='"+password+"';";
                  ResultSet dado=acessar.executeQuery(sql);
                  if(dado.next()){
                      int valor=dado.getInt("valor");
                      if(valor==0){
                          out.println("<h1> Usuario  Incorreto ! </h1>");
                          out.println("<p>Usuario e/ou senha incorretos ou inexistentes.<br><br><a href='docentes.jsp?user="+user+"'>Clique aqui para voltar</a></p>");
                      }else{
                          out.println("<meta http-equiv='refresh' content='0.2; url=gerenciaprof.jsp?user="+user+"'>");
                      }
                  }
              }catch(SQLException sqlex){
                  out.println("Erro de  SQL:"+sqlex);
              }
        %>
    </body>
</html>
