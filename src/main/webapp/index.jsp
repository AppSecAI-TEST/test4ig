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
<%@page import="ru.simsonic.test4ig.Product"%>

<%!
   EntityManagerFactory sessionFactory;
   
   public void jspInit() {
      sessionFactory = Persistence.createEntityManagerFactory("ru.simsonic.test4ig.persistence");
   }
   public void jspDestroy() {
      sessionFactory.close();
   }
%>

<%
   String postCategory = "";
   String postProduct  = "";
   String postMinPrice = "";
   String postMaxPrice = "";
   
   final boolean post = "POST".equals(request.getMethod());
   
   if(post) {
      postCategory = request.getParameter("category");
      postProduct  = request.getParameter("product");
      postMinPrice = request.getParameter("minprice");
      postMaxPrice = request.getParameter("maxprice");
      
      EntityManager entityManager = sessionFactory.createEntityManager();
      entityManager.getTransaction().begin();
      // entityManager.persist(new Event("Our very first event!", new Date()));
      // entityManager.persist(new Event("A follow up event",     new Date()));
      entityManager.getTransaction().commit();
      entityManager.close();
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
            <td><input id="category" name="category" type="text"               value="<%= postCategory != null ? postCategory : "" %>" /></td>
            <td><input id="product"  name="product"  type="text"               value="<%= postProduct  != null ? postProduct  : "" %>" /></td>
            <td><input id="minprice" name="minprice" type="number" step="0.01" value="<%= postMinPrice != null ? postMinPrice : "" %>" /></td>
            <td><input id="maxprice" name="maxprice" type="number" step="0.01" value="<%= postMaxPrice != null ? postMaxPrice : "" %>" /></td>
            <td><input id="submit"                   type="submit"             value="Найти" /></td>
         </tr>
      </table>
   </form>

   <%
      if(post) {
   %>
   
      <h3>Результаты поиска:</h3>
      <%
         int count = 10;
         if(count > 0) {
      %>
            <table class="resulttable">
               <tr>
                  <td>Категория:</td>
                  <td>Наименование:</td>
                  <td>Цена:</td>
               </tr>
      <%
            List<Product> results = new ArrayList<>(); // TO DO HERE
            for(Product product : results) {
      %>
               <tr>
                  <td><%= product.getCategory().getName()    %></td>
                  <td><%= product.getName()                  %></td>
                  <td><%= product.getPrice().toPlainString() %></td>
               </tr>
      <%
            }
      %>
            </table>
      <%
         } else {
      %>
            <p class = 'notfound'>Соответствий не найдено.</p>
      <%
         }
      }
   %>
</body>
</html>
