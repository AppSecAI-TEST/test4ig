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
   String postCategory = "";
   String postProduct  = "";
   String postMinPrice = "";
   String postMaxPrice = "";
   int pageSize = ShopDAO.DEFAULT_PAGE_SIZE;
   
   // Контейнер с результатами поиска
   final List<Product> foundResults = new ArrayList<>();
   
   // Форма должна быть передана только через POST, поэтому, если метод отличается,
   // мы не будем искать результаты.
   final boolean post = "POST".equals(request.getMethod());
   
   if(post) {
      request.setCharacterEncoding("UTF-8");
      String category = request.getParameter("category");
      String product  = request.getParameter("product");
      String minPrice = request.getParameter("minprice");
      String maxPrice = request.getParameter("maxprice");
      
      // Определение размера страницы результатов
      try {
         pageSize = Integer.parseInt(request.getParameter("pagesize"));
         pageSize = Math.max(pageSize, ShopDAO.PAGE_SIZE_1);
         pageSize = Math.min(pageSize, ShopDAO.PAGE_SIZE_3);
      } catch(NumberFormatException ex) {
      }
      
      // Определение номера первого результата
      int pageNumb = ShopDAO.DEFAULT_PAGE_SIZE;
      try {
         pageSize = Integer.parseInt(request.getParameter("page"));
         pageSize = Math.max(pageSize, ShopDAO.PAGE_SIZE_1);
         pageSize = Math.min(pageSize, ShopDAO.PAGE_SIZE_3);
      } catch(NumberFormatException ex) {
      }

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
   <div class=container">
   <a class="homeLink" href="<%= request.getRequestURI() %>"><h2>Прайс-лист</h2></a>
   <form method="post" action="<%= request.getRequestURI() %>">
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
                  <td style="width: 20%;">Категория:</td>
                  <td style="width: 65%;">Наименование:</td>
                  <td style="width: 15%;">Цена, руб.:</td>
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
            <p>
            Количество результатов на странице:
            <form method="post" action="<%= request.getRequestURI() %>">
               <input type="hidden" name="category" value="<%= postCategory %>" />
               <input type="hidden" name="product"  value="<%= postProduct  %>" />
               <input type="hidden" name="minprice" value="<%= postMinPrice %>" />
               <input type="hidden" name="maxprice" value="<%= postMaxPrice %>" />
               <%
                  if(pageSize == ShopDAO.PAGE_SIZE_1)
                     out.print(pageSize);
                  else {
               %>
                     <input type="submit" name="pagesize" value="<%= ShopDAO.PAGE_SIZE_1 %>" class="pageButton" />
               <%
                  }
                  if(pageSize == ShopDAO.PAGE_SIZE_2)
                     out.print(pageSize);
                  else {
               %>
                     <input type="submit" name="pagesize" value="<%= ShopDAO.PAGE_SIZE_2 %>" class="pageButton" />
               <%
                  }
                  if(pageSize == ShopDAO.PAGE_SIZE_3)
                     out.print(pageSize);
                  else {
               %>
                     <input type="submit" name="pagesize" value="<%= ShopDAO.PAGE_SIZE_3 %>" class="pageButton" />
               <%
                  }
               %>
            </form>
            </p>
   <%
         }
      }
   %>
   </div>
</body>
</html>
