package ru.simsonic.test4ig;

import java.io.IOException;
import java.io.PrintWriter;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CatalogServlet extends HttpServlet {
   
   EntityManagerFactory sessionFactory;

   @Override
   public void init() {
      sessionFactory = Persistence.createEntityManagerFactory("ru.simsonic.test4ig.persistence");
   }

   @Override
   public void destroy() {
      sessionFactory.close();
   }

   /**
    * Returns a short description of the servlet.
    * @return a String containing servlet description
    */
   @Override
   public String getServletInfo() {
      return "Generic catalog servlet";
   }
   
   /**
    * Handles the HTTP <code>GET</code> method.
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      processRequest(request, response);
   }

   /**
    * Handles the HTTP <code>POST</code> method.
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      processRequest(request, response);
   }
   
   /**
    * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
   private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      EntityManager session = sessionFactory.createEntityManager();
      session.getTransaction().begin();
      // entityManager.persist(new Event("Our very first event!", new Date()));
      // entityManager.persist(new Event("A follow up event",     new Date()));
      session.getTransaction().commit();
      session.close();
      
      response.setContentType("text/html; charset=UTF-8");
      try (final PrintWriter out = response.getWriter()) {
      }
   }
}
