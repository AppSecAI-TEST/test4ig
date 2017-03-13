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
<%@page import="ru.simsonic.test4ig.Entities.Product"%>

<%!
   public void jspInit() {
      ShopDAO.init();
   }

   public void jspDestroy() {
      ShopDAO.close();
   }
%>

<%
   int    pageSize     = ShopDAO.DEFAULT_PAGE_SIZE;
   int    pageNumber   = 1;
   int    pagesCount   = 1;
   int    totalFound   = 0;
   
   // Заполнители формы использованными ранее значениями
   String postCategory = "";
   String postProduct  = "";
   String postMinPrice = "";
   String postMaxPrice = "";
   
   // Контейнер с результатами поиска
   List<Product> foundResults = new ArrayList<>();
   
   // Описание внутренней ошибки
   Throwable searchException = null;
   
   // Форма должна быть передана только через POST, поэтому, если метод отличается,
   // мы не будем искать результаты.
   final boolean post = "POST".equals(request.getMethod());
   
   if(post) {
      request.setCharacterEncoding("UTF-8");
      postCategory = request.getParameter("category");
      postProduct  = request.getParameter("product");
      postMinPrice = request.getParameter("minprice");
      postMaxPrice = request.getParameter("maxprice");
      postCategory = null != postCategory ? postCategory : "";
      postProduct  = null != postProduct  ? postProduct  : "";
      postMinPrice = null != postMinPrice ? postMinPrice : "";
      postMaxPrice = null != postMaxPrice ? postMaxPrice : "";
      
      // Определение размера страницы результатов
      try {
         pageSize = Integer.parseInt(request.getParameter("pagesize"));
         pageSize = Math.max(pageSize, ShopDAO.MINIMUM_PAGE_SIZE);
         pageSize = Math.min(pageSize, ShopDAO.MAXIMUM_PAGE_SIZE);
      } catch(NumberFormatException ex) {
         // Используем значение по умолчанию
      }
      
      // Определение номера первого результата
      try {
         pageNumber = Integer.parseInt(request.getParameter("page"));
         pageNumber = Math.max(pageNumber, 1);
      } catch(NumberFormatException ex) {
         // Используем значение по умолчанию
      }
      
      // Magic
      try {
         foundResults.addAll(ShopDAO.runSearch(postCategory, postProduct, postMinPrice, postMaxPrice));
      
      } catch (IllegalArgumentException ex) {
         // Допустимое для вывода пользователю сообщение
         searchException = ex;
      }
      
      totalFound = foundResults.size();
      
      // Вычисление числа страниц и показываемых результатов
      if(totalFound > 0) {
         // Общее количество полностью заполненных страниц и потенциально одной неполной в конце
         pagesCount   = (totalFound / pageSize) + (totalFound % pageSize > 0 ? 1 : 0);
         // Ограничиваем максимальный номер страницы
         pageNumber   = Math.min(pageNumber, pagesCount);
         // Удаляем элементы из списка, которые мы не хотим выводить
         int first    = (pageNumber - 1) * pageSize;
         int last     = Math.min(first + pageSize, totalFound);
         foundResults = foundResults.subList(first, last);
      } else {
         pageNumber   = 1;
         pagesCount   = 1;
      }
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
      <input type="hidden" name="pagesize" value="<%= pageSize %>" />
   </form>

   <%
      if(post) {
         
         out.println("<h3>Результаты поиска:</h3>");
         
         if(foundResults.isEmpty()) {
            
            // Вывод ошибки поиска или факта отсутствия результатов
            out.println("<p class='notfound'>");
            out.println(searchException != null
               ? searchException.getMessage()
               : "Соответствий не найдено.");
            out.println("</p>");
            
         } else {
   %>
            <table class="resulttable">
               <tr>
                  <td style="width: 20%;"><b>Категория:   </b></td>
                  <td style="width: 65%;"><b>Наименование:</b></td>
                  <td style="width: 15%;"><b>Цена, руб.:  </b></td>
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
            
            <p>Всего найдено <%= totalFound %> товарных позиций.</p>
            
            <table width="100%"><tr>
            <%-- Переключатели размеров страниц --%>
            <td width="50%"><form method="post" action="<%= request.getRequestURI() %>">
               Количество результатов на странице:<br />
               <input type="hidden" name="category" value="<%= postCategory %>" />
               <input type="hidden" name="product"  value="<%= postProduct  %>" />
               <input type="hidden" name="minprice" value="<%= postMinPrice %>" />
               <input type="hidden" name="maxprice" value="<%= postMaxPrice %>" />
               <%-- Мы не будем передавать значение page в этой форме, тем самым сбрасывая номер страницы на 1 --%>
               <%
                  // Вывод списка разрешённых значений размеров страниц с результатами
                  for(int availablePS : ShopDAO.AVAILABLE_PAGE_SIZES)
                     out.print(pageSize != availablePS
                        ? "<input type=\"submit\" name=\"pagesize\" value=\"" + availablePS + "\" class=\"pageButton\" />"
                        : pageSize);
               %>
            </form></td>
            <%-- Переключатели номеров страниц --%>
            <td width="50%"><form method="post" action="<%= request.getRequestURI() %>">
               Переход на страницу результатов:<br />
               <input type="hidden" name="category" value="<%= postCategory %>" />
               <input type="hidden" name="product"  value="<%= postProduct  %>" />
               <input type="hidden" name="minprice" value="<%= postMinPrice %>" />
               <input type="hidden" name="maxprice" value="<%= postMaxPrice %>" />
               <input type="hidden" name="pagesize" value="<%= pageSize     %>" />
               <%
                  for(int availablePN = 1; availablePN <= pagesCount; availablePN += 1)
                     out.print(pageNumber != availablePN
                        ? "<input type=\"submit\" name=\"page\" value=\"" + availablePN + "\" class=\"pageButton\" />"
                        : pageNumber);
               %>
            </form></td>
            
            </tr><table>
   <%
         }
      }
   %>
   </div>
</body>
</html>
