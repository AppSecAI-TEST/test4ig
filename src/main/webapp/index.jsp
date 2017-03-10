<%-- 
    Document   : index
    Created on : 10.03.2017, 11:33:00
    Author     : simsonic
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="ru.simsonic.test4ig.DAO.ShopDAO"%>
<%@page import="ru.simsonic.test4ig.Product"%>

<%!
   public void jspInit() {
      ShopDAO.init();
   }

   public void jspDestroy() {
      ShopDAO.close();
   }
%>

<%
   final EntityManagerFactory sessionFactory =
      Persistence.createEntityManagerFactory("ru.simsonic.test4ig.persistence");

   String postCategory = "";
   String postProduct  = "";
   String postMinPrice = "";
   String postMaxPrice = "";
      
   final List<Product> foundResults = new ArrayList<>();
   
   final boolean post = "POST".equals(request.getMethod());
   
   if(post) {
      String category = request.getParameter("category");
      String product  = request.getParameter("product");
      String minPrice = request.getParameter("minprice");
      String maxPrice = request.getParameter("maxprice");

      // Magic
      foundResults.addAll(ShopDAO.runSearch(category, product, minPrice, maxPrice));
      
      // This should be returned into form's fields
      postCategory = null != category ? category : "";
      postProduct  = null != product  ? product  : "";
      postMinPrice = null != minPrice ? minPrice : "";
      postMaxPrice = null != maxPrice ? maxPrice : "";
   }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <title>Каталог продукции</title>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link rel="stylesheet" type="text/css" href="catalog.css">
</head>
<body>
   <h1>Прайс-лист</h1>
   <form method="post" action="/test4ig/">
      <table>
         <tr>
            <td>Категория:</td>
            <td>Наименование:</td>
            <td>Цена от:</td>
            <td>Цена до:</td>
            <td></td>
         </tr>
         <tr>
            <td><input id="category" name="category" type="text"               value="<%= postCategory %>" /></td>
            <td><input id="product"  name="product"  type="text"               value="<%= postProduct  %>" /></td>
            <td><input id="minprice" name="minprice" type="number" step="0.01" value="<%= postMinPrice %>" /></td>
            <td><input id="maxprice" name="maxprice" type="number" step="0.01" value="<%= postMaxPrice %>" /></td>
            <td><input id="submit"                   type="submit"             value="Найти" /></td>
         </tr>
      </table>
   </form>

   <%
      if(post) {
         
         out.println("<h3>Результаты поиска:</h3>");
         
         if(foundResults.isEmpty()) {
            out.println("<p class='notfound'>Соответствий не найдено.</p>");
            
         } else {
   %>
      <table class="resulttable">
         <tr>
            <td>Категория:</td>
            <td>Наименование:</td>
            <td>Цена:</td>
         </tr>
   <%
            for(Product product : foundResults) {
               out.print("<tr>");
               out.print("<td>" + product.getCategory().getName()    + "</td>");
               out.print("<td>" + product.getName()                  + "</td>");
               out.print("<td>" + product.getPrice().toPlainString() + "</td>");
               out.print("</tr>");
               out.println();
            }
   %>
      </table>
   <%
         }
      }
   %>
</body>
</html>
