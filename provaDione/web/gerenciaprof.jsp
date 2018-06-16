<%-- 
    Document   : gerenciaprof
    Created on : 15/06/2018, 18:51:50
    Author     : felipe
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="CSS/estilo.css">
        <title>Gerenciar professores</title>
    </head>
    <body>
        <%
            Connection conectar = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String user = "root";
                String password = "";
                String url = "jdbc:mysql://localhost/prova_dione";
                conectar = DriverManager.getConnection(url, user, password);
            } catch (ClassNotFoundException clex) {
                out.println("Erro ao carregar o drive do MySQL:" + clex);
            } catch (SQLException sqlex) {
                out.println("Erro ao acessar o banco:" + sqlex);
            } catch (Exception ex) {
                out.println("Erro:" + ex);
            }
            String codigo_param = request.getParameter("codigo");
            String user = request.getParameter("user");
            if (codigo_param == null) {
                out.println("<h1> Bem-vindo " + user+"</h1>");
            }
            out.println("<p class='user'> Usuario: "+user+" </p>");
        %>
        <h1 style="text-align: center;"> Relaçao de professores cadastrados </h1>
        <br>
        <table>
            <tr style="text-align: center;">
                <td> Nome </td>
                <td> Titulacaçao </td>
                <td> E-mail </td>
                <td> Curriculo </td>
                <td colspan="2"></td>
            </tr>
            <%
                try {
                    Statement acessar = conectar.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    String sql = "Select * from Professor order by nome;";
                    ResultSet dados = acessar.executeQuery(sql);
                    while (dados.next()) {
                        String codigo, nome, email, link_curriculo, titulacao;
                        codigo = dados.getString("codigo");
                        nome = dados.getString("nome");
                        email = dados.getString("email");
                        link_curriculo = dados.getString("link_curriculo");
                        titulacao = dados.getString("titulacao");
                        out.println("<tr>");
                        out.println("<td>" + nome + "</td>");
                        out.println("<td>" + titulacao + "</td>");
                        out.println("<td>" + email + "</td>");
                        out.println("<td>" + link_curriculo + "</td>");
                        out.println("<td><a href='gerenciaprof.jsp?codigo=" + codigo + "'><img src='IMG/edit.png' width='25' height='25' title='Alterar'></a></td>");
                        out.println("<td><img src='IMG/excluir.png' width='25' height='25' title='Excluir'></td>");
                        out.println("</tr>");
                    }
                } catch (SQLException sqlex) {
                    out.println("Erro de SQL:" + sqlex);
                }
            %>
        </table>
    </body>
</html>
