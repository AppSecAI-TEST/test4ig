package ru.simsonic.test4ig.DAO;

import java.util.Collections;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import ru.simsonic.test4ig.Product;

public class ShopDAO {
   
   private static EntityManagerFactory sessionFactory;
   
   public static void init() {
      // Singleton initialization
      try {
         sessionFactory = Persistence.createEntityManagerFactory("ru.simsonic.test4ig.persistence");
      } catch (Throwable ex) {
         System.err.println("Initialization of EntityManagerFactory failed: " + ex);
         throw new ExceptionInInitializerError(ex);
      }
   }
   
   public static void close() {
      sessionFactory.close();
   }
   
   public static EntityManagerFactory getSessionFactory() {
      return sessionFactory;
   }
   
   public static List<Product> runSearch(String category, String product, String minPrice, String maxPrice) {
      
      try {
         final EntityManager session = sessionFactory.createEntityManager();
      
         session.getTransaction().begin();
         // entityManager.persist(new Event("Our very first event!", new Date()));
         // entityManager.persist(new Event("A follow up event",     new Date()));
         session.getTransaction().commit();
         session.close();
         
      } catch (Throwable ex) {
         System.err.println("Has EntityManagerFactory been really closed?!?: " + ex);
      }
      
      // DUMMY
      return Collections.EMPTY_LIST;
   }
}
