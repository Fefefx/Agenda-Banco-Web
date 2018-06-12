<%-- 
    Document   : operar
    Created on : 11/06/2018, 16:53:55
    Author     : felipe
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gerenciar registros</title>
    </head>
    <body>
        <%
            if(request.getParameter("name").equals("incluir")&&request.getParameter("cad_pessoa")==null){
        %>
                <h1> Incluir usuario </h1>
                <form action="#" method="post">
                    <p> Digite o nome da pessoa: </p>
                    <input type="text" size="20" name="nome_pessoa">
                    <p> Digite o telefone: </p>
                    <input type="text" size="20" name="telefone_pessoa">
                    <br> <br>
                    <input type="submit" value="Cadastrar" name="cad_pessoa">
                </form>
        <%
            }else if(request.getParameter("name").equals("incluir")&&request.getParameter("cad_pessoa")!=null){
                Connection conectar=null;
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    String user="root";
                    String password="";
                    String bank="agenda";
                    String url="jdbc:mysql://localhost/"+bank;
                    conectar=DriverManager.getConnection(url, user, password);
                }catch(ClassNotFoundException clex){
                    out.println("Erro ao carregar o Driver do MYSQL: "+clex);
                }catch(SQLException sqlex){
                    out.println("Erro ao acessar o banco de dados: "+sqlex);
                }catch(Exception ex){
                    out.println("Erro: "+ex);
                }
                try{
                    Statement acessar=conectar.createStatement();
                    String nome=request.getParameter("nome_pessoa");
                    String telefone=request.getParameter("telefone_pessoa");
                    String sql="insert into Pessoas(nome,telefone) values('"+nome+"','"+telefone+"');";
                    int res=acessar.executeUpdate(sql);
                    if(res==-1){
                        out.println("Erro ao inserir o registro !");
                    }else{
                        %>
                            <h1>Inserir registro</h1>
                            <a href="index.jsp">Registro inserido com sucesso</a>
                        <%
                    }
                }catch(SQLException sqlex){
                    out.println("Erro de SQL: "+sqlex);
                }
            }
        %>
    </body>
</html>
