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
            String operacao=request.getParameter("op");
            String cadastro=request.getParameter("cadProf");
            String alterar=request.getParameter("altProf");
            out.println("<p class='user'> Usuario: "+user+"<a href='docentes.jsp'>"
                    + "<img src='IMG/shutdown.png' title='Sair' width='25' height='25'></a></p>");
            if (operacao == null) {
                out.println("<h1 style='margin-left:5%;'> Bem-vindo " + user+"</h1>");
            }
            if(operacao==null || operacao.equals("mostrar")){
        %>
        <h1 style="text-align: center;"> Relaçao de professores cadastrados </h1>
        <br>
        <table>
        <%
        out.println("<tr><td><form action='gerenciaprof.jsp?user="+user+"&op=mostrar' method='post'>");
        %>
            Pesquisar professor: <input type="text" size="20" name="pesquisa">
            <input type="submit" value="Filtrar" name="filtro"> </td> 
        </form>
        <%
        out.println("<td><a href='gerenciaprof.jsp?op=inserir&user="+user+"'><img src='IMG/add.png' width='25' height='25' title='Adicionar professor'</td></a>");
        out.println("<td><a href='gerenciaprof.jsp?op=mostrar&user="+user+"'><img src='IMG/refresh.png' width='25' height='25' title='Mostrar tudo'> </td></a></tr>");
        %>
        </table>
        <table>
            <tr style="text-align: center;">
                <td> Nome </td>
                <td> Titulaçao </td>
                <td> E-mail </td>
                <td> Curriculo </td>
                <td colspan="2"></td>
            </tr>
            <%
                try {
                    Statement acessar = conectar.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    String sql;
                    if(request.getParameter("filtro")==null){
                        sql = "Select * from Professor order by nome;";
                    }else{
                        String filtro=request.getParameter("pesquisa");
                        sql = "Select * from Professor where nome like '"+filtro+"%' order by nome;"; 
                    }
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
                        out.println("<td> <a href='mailto:"+email+"'>" + email + "</a></td>");
                        out.println("<td> <a href='"+link_curriculo+"' target='_blank'>" + link_curriculo + "</a></td>");
                        out.println("<td><a href='gerenciaprof.jsp?codigo=" + codigo + "&user="+user+"&op=alterar'>"
                                + "<img src='IMG/edit.png' width='25' height='25' title='Alterar'></a></td>");
                        out.println("<td><a href='gerenciaprof.jsp?codigo="+codigo+"&user="+user+"&op=excluir'>"
                                + "<img src='IMG/excluir.png' width='25' height='25' title='Excluir'></a></td>");
                        out.println("</tr>");
                    }
                } catch (SQLException sqlex) {
                    out.println("Erro de SQL:" + sqlex);
                }
            }else if(operacao.equals("inserir")&&cadastro==null){
                %>
                <h2> Cadastrar professor </h2>
               <% out.println("<form action='gerenciaprof.jsp?op=inserir&user="+user+"' method='post'>"); %>
                    <p>Nome:&nbsp;&nbsp;<input type="text" size="40" name="new_nome"> </p>
                    <p>Titulacao:&nbsp;&nbsp;<input type="text" size="10" name="new_titulacao"></p>
                    <p>E-mail:&nbsp;&nbsp;<input type="text" size="40" name="new_email"></p>
                    <p>Link do curriculo:&nbsp;&nbsp;<input type="text" size="40" name="new_curriculo"></p>
                    <input type="submit" value="Cadastrar" name="cadProf">
                </form>
                <%
            }else if(operacao.equals("inserir")&&cadastro!=null){
                String new_nome=request.getParameter("new_nome");
                String new_titulacao=request.getParameter("new_titulacao");
                String new_email=request.getParameter("new_email");
                String new_curriculo=request.getParameter("new_curriculo");
                try{
                    Statement acessar=conectar.createStatement();
                    String sql="insert into Professor(nome,email,link_curriculo,titulacao) VALUES ('"+new_nome+"','"+new_email+"','"
                    +new_curriculo+"','"+new_titulacao+"');";
                    int res=acessar.executeUpdate(sql);
                    if(res!=-1){
                        out.println("<h1> Professor(a) inserido !</h1>");
                        out.println("<p><a href='gerenciaprof.jsp?op=mostrar&user="+user+"'>Voltar</a></p>");
                    }else{
                        out.println("Erro ao inserir o professor !");
                    }
                }catch(SQLException sqlex){
                    out.println("Erro de SQL:"+sqlex);
                }
            }else if(operacao.equals("excluir")){
                try{
                    Statement acessar=conectar.createStatement();
                    String sql="delete from Professor where codigo="+codigo_param+";";
                    int res=acessar.executeUpdate(sql);
                    if(res!=-1){
                        out.println("<h1> Exclusao de professor realizada com sucesso ! </h1>");
                        out.println("<p><a href='gerenciaprof.jsp?op=mostrar&user="+user+"'>Voltar</a></p>");                        
                    }else{
                        out.println("Erro ao excluir o professor !");
                    }
                }catch(SQLException sqlex){
                    out.println("Erro de SQL:"+sqlex);
                }
            }else if(operacao.equals("alterar")&&alterar==null){
                try{
                    Statement acessar=conectar.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                    String sql="Select * from Professor where codigo="+codigo_param+";";
                    ResultSet dados=acessar.executeQuery(sql);
                    if(dados.next()){
                        String v_nome=dados.getString("nome");
                        String v_titulacao=dados.getString("titulacao");
                        String v_email=dados.getString("email");
                        String v_curriculo=dados.getString("link_curriculo");
                        String v_codigo=dados.getString("codigo");
                        out.println("<h1>Alterar professor</h1>");
                        out.println("<form action='gerenciaprof.jsp?op=alterar&user="+user+"' method='post'>");
                        out.println("<p>Codigo:&nbsp;&nbsp;<input style='text-align:center;' type='text' size='1.5' name='alt_codigo' value='"+v_codigo+"' readonly='true'></p>");
                        out.println("<p> Nome:&nbsp;&nbsp;<input type='text' size='40' name='alt_nome' value='"+v_nome+"' ></p>");
                        out.println("<p> Titulaçao:&nbsp;&nbsp;<input type='text' size='10' name='alt_titulacao' value='"+v_titulacao+"'></p>");
                        out.println("<p> E-mail:&nbsp;&nbsp;<input type='text' size='40' name='alt_email' value='"+v_email+"'></p>");
                        out.println("<p> Link do Curriculo:&nbsp;&nbsp;<input type='text' size='40' name='alt_curriculo' value='"+v_curriculo+"'></p>");
                        out.println("<input type='submit' value='Atualizar' name='altProf'>"); 
                    }
                }catch(SQLException sqlex){
                     out.println("Erro de SQL:"+sqlex);
                }
            }else if(operacao.equals("alterar")&&alterar!=null){
                String alt_nome,alt_titulacao,alt_email,alt_curriculo,alt_codigo;
                alt_codigo=request.getParameter("alt_codigo");
                alt_nome=request.getParameter("alt_nome");
                alt_email=request.getParameter("alt_email");
                alt_curriculo=request.getParameter("alt_curriculo");
                alt_titulacao=request.getParameter("alt_titulacao");
                try{
                    Statement acessar=conectar.createStatement();
                    String sql="update Professor set nome='"+alt_nome+"', email='"+alt_email+"', link_curriculo='"
                    +alt_curriculo+"', titulacao='"+alt_titulacao+"' where codigo="+alt_codigo+";";
                    int res=acessar.executeUpdate(sql);
                    if(res!=-1){
                        out.println("<h1> Alteracao de professor realizada com sucesso ! </h1>");
                        out.println("<p><a href='gerenciaprof.jsp?op=mostrar&user="+user+"'>Voltar</a></p>"); 
                    }else{
                        out.println("Erro ao alterar o professor !");
                    }
                }catch(SQLException sqlex){
                    out.println("Erro de SQL:"+sqlex);
                }
            }
            %>
        </table>
    </body>
</html>
