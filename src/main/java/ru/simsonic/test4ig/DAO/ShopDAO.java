package ru.simsonic.test4ig.DAO;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
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
         final EntityManager       session = sessionFactory.createEntityManager();
         final TypedQuery<Product> query   = session.createQuery("SELECT p FROM Product p "
				+ "WHERE p.category.name LIKE :category "
				+ "AND   p.name          LIKE :name     "
				+ "AND   p.price         >=   :minPrice "
				+ "AND   p.price         <=   :maxPrice ", Product.class)
            .setParameter("category", category + "%")
            .setParameter("name",     product  + "%")
            .setParameter("minPrice", toBigDecimal(minPrice, false))
            .setParameter("maxPrice", toBigDecimal(maxPrice, true))
            // .setFirstResult(0)
            // .setMaxResults(50)
               ;
         
         final List<Product> result = query.getResultList();
         session.close();
         return result;
         
      } catch (Throwable ex) {
         System.err.println("Has EntityManagerFactory been really closed?!?: " + ex);
      }
      
      // DUMMY
      return Collections.EMPTY_LIST;
   }
   
   private static BigDecimal toBigDecimal(String value, boolean higher) {
      try {
         return new BigDecimal(value);
      } catch(NumberFormatException ex) {
         return higher
            ? BigDecimal.valueOf(Double.MAX_VALUE)
            : BigDecimal.ZERO;
      }
   }
}
