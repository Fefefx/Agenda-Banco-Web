<%-- 
    Document   : index
    Created on : 15/06/2018, 15:15:55
    Author     : felipe
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FATEC - Faculdade de Tecnologia de Presidente Prudente</title>
        <link rel="stylesheet" type="text/css" href="CSS/estilo.css">
    </head>
    <body>
        <form method="post" action="validausuario.jsp">
            <p>Login:&nbsp;&nbsp;<input type="text" size="20" name="user" required="required"></p>
            <p>Senha:&nbsp;&nbsp;<input type="password" size="20" name="password" required="required"></p>
            <input type="submit" value="Gerenciar Professores">
        </form>
        <h2>Faculdade de Tecnologia de Presidente Prudente</h2>
        <br>
        <table>
            <tr style="text-align: center;">
                <td>Docentes</td>
                <td>Titulaçao</td>
                <td>E-mail</td>
                <td>Curriculo Lates</td>
            </tr>
            <%
                Connection conectar=null;
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    String user="root";
                    String password="";
                    String url="jdbc:mysql://localhost/prova_dione";
                    conectar=DriverManager.getConnection(url, user, password);
                }catch(ClassNotFoundException clex){
                    out.println("Erro ao carregar o Driver do MySQL:"+clex);
                }catch(SQLException sqlex){
                    out.println("Erro ao acessar o banco de dados:"+sqlex);
                }catch(Exception ex){
                    out.println("Erro:"+ex);
                }
                Statement acessar=null;
                try{
                    acessar=conectar.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                    String sql="Select nome,email,link_curriculo,titulacao from Professor order by nome";
                    ResultSet dados=acessar.executeQuery(sql);
                    while(dados.next()){
                        String nome,email,link_curriculo,titulacao;
                        nome=dados.getString("nome");
                        email=dados.getString("email");
                        link_curriculo=dados.getString("link_curriculo");
                        titulacao=dados.getString("titulacao");
                        out.println("<tr>");
                        out.println("<td>"+nome+"</td>");
                        out.println("<td>"+titulacao+"</td>");
                        out.println("<td style='text-align:center;'> <a href= 'mailto:"+email+"'>"+email+"</a></td>");
                        out.println("<td style='text-align:center;'> <a href='"+link_curriculo+"' target='_blank'>"
                                + "<img src='IMG/cv.png' width='25' height='25' title='Ver curriculo'></a></td>");
                        out.println("</tr>");
                    }
                }catch(SQLException sqlex){
                    out.println("Erro de SQL:"+sqlex);
                }
            %>
        </table>
     </body>
</html>
