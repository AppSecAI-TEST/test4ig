<%-- 
    Document   : index
    Created on : 10.03.2017, 11:33:00
    Author     : simsonic
--%>

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
   <form id="search" method="post" action="/test4ig/">
      <table>
         <tr>
            <td>Категория:</td>
            <td>Наименование:</td>
            <td>Цена от:</td>
            <td>Цена до:</td>
            <td></td>
         </tr>
         <tr>
            <td><input id="category" name="category" type="text"               value="$(category)" /></td>
            <td><input id="product"  name="product"  type="text"               value="$(product)" /></td>
            <td><input id="minprice" name="minprice" type="number" step="0.01" value="$(minprice)" /></td>
            <td><input id="maxprice" name="maxprice" type="number" step="0.01" value="$(maxprice)" /></td>
            <td><input id="submit"                   type="submit"             value="Найти" /></td>
         </tr>
      </table>
   </form>

   <%
      String x = "";
   %>
     
   <h3>Результаты поиска:</h3>
   <table class="resulttable">
         <tr>
            <td>Категория:</td>
            <td>Наименование:</td>
            <td>Цена:</td>
         </tr>
      <tr>
         <td>$(Category)</td>
         <td>$(Product)</td>
         <td>$(Price)</td>
      </tr>
      <tr>
         <td>$(Category)</td>
         <td>$(Product)</td>
         <td>$(Price)</td>
      </tr>
      <tr>
         <td>$(Category)</td>
         <td>$(Product)</td>
         <td>$(Price)</td>
      </tr>
   </table>

   Соответствий не найдено.

</body>
</html>
