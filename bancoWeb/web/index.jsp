<%-- 
    Document   : index
    Created on : 11/06/2018, 16:37:20
    Author     : felipe
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visualizar pessoas</title>
    </head>
    <body>

        <%
            Connection conectar=null;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                String user="root";
                String password="";
                String bank="agenda";
                String url="jdbc:mysql://localhost/"+bank;
                conectar=DriverManager.getConnection(url, user, password);
            }catch(ClassNotFoundException clex){
                out.println("Erro ao carregar o Driver do MySQL: "+clex);
            }catch(SQLException sqlex){
                out.println("Erro ao acessar o banco de dados: "+sqlex);
            }catch(Exception ex){
                out.println("Erro: "+ex);
            }
            if (request.getParameter("excluir") == null||request.getParameter("excluir").equals("feito")) {
        %>
                <h1>Agenda de pessoas</h1>
                <a href="operar.jsp?name=incluir"><img src="IMG/add.png" title="Adicionar" height="25px" width="25px"></a>
                <table>
                    <tr>
                        <td> Nome </td>
                        <td> Telefone: </td>
                        <td colspan="2"></td>
                    </tr>
                <%
                try{
                    Statement acessar=conectar.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                    String sql="Select * from Pessoas order by nome;";
                    ResultSet consulta=acessar.executeQuery(sql);
                    try{
                        while(consulta.next()){
                            String codigo=consulta.getString("codigo");
                            String nome=consulta.getString("nome");
                            String telefone=consulta.getString("telefone");
                            out.println("<tr>");
                            out.println("<td>"+nome+"</td>");
                            out.println("<td>"+telefone+"</td>");
                            out.println("<td><a href='operar.jsp?alterar="+codigo+"'><img src='IMG/edit.png' width='25px' height='25px' title='Alterar'></a></td>");
                            out.println("<td><a href='index.jsp?excluir="+codigo+"'><img src='IMG/excluir.png' width='25px' height='25px' title='Excluir'></a></td>");
                            out.println("</tr>");
                        }
                    }catch(SQLException sqlex){
                        out.println("Erro ao percorrer o ResultSet: "+sqlex);
                    }
                }catch(SQLException sqlex){
                    out.println("Erro de SQL: "+sqlex);
                }
                %>
                </table>
                <% 
            }else{
                 try{
                    Statement acessar=conectar.createStatement();
                    String codigo=request.getParameter("excluir");
                    String sql="delete from Pessoas where codigo="+codigo;
                    int res=acessar.executeUpdate(sql);
                    if(res==-1){
                        out.println("Erro ao excluir a pessoa !");
                    }else{
                        %>
                            <h1>Excluir pessoa</h1>
                            <a href="index.jsp?excluir=feito">Voltar para Index</a>
                        <%
                    }
                }catch(SQLException sqlex){
                    out.println("Erro de SQL: "+sqlex);
                }
            }
                %>
    </body>
</html>
