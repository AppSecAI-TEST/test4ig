package ru.simsonic.test4ig.DAO;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import ru.simsonic.test4ig.Entities.Product;

public class ShopDAO {

   /**
    * Список размерностей страниц вывода результата.
    */
   public static final int[] AVAILABLE_PAGE_SIZES = { 5, 10, 20, 50, 100, 200, };

   /**
    * Минимально допустимое количество элементов на странице вывода результатов.
    */
   public static final int   MINIMUM_PAGE_SIZE    = Arrays.stream(AVAILABLE_PAGE_SIZES).min().getAsInt();
   
   /**
    * Количество элементов на странице вывода результатов по умолчанию.
    */
   public static final int   DEFAULT_PAGE_SIZE    = 10;
   
   /**
    * Максимально допустимое количество элементов на странице вывода результатов.
    */
   public static final int   MAXIMUM_PAGE_SIZE    = Arrays.stream(AVAILABLE_PAGE_SIZES).max().getAsInt();
   
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
   
   /**
    * Данный метод осуществляет поиск наименований, соответствующих заданным критериям.
    * Хотя бы один параметр из category, product, minPrice и maxPrice должен быть задан.<br />
    * 
    * @param category Подстрока, с которой должно начинаться название категории. Если начинается с %, то
    * подстрока может быть найдена в середине или в конце названия категории.
    * Может быть пустой строкой (""). Не может быть null.<br />
    * 
    * @param product Подстрока, с которой должно начинаться название наименования. Если начинается с %, то
    * подстрока может быть найдена в середине или в конце названия наименования.
    * Может быть пустой строкой (""). Не может быть null.<br />
    * 
    * @param minPrice Минимальная цена (включительно), которой должен соответствовать товар.
    * Может быть пустой строкой (""). Не может быть null.<br />
    * 
    * @param maxPrice Максимальная цена (включительно), которой должен соответствовать товар.
    * Может быть пустой строкой (""). Не может быть null.<br />
    * 
    * @return Список найденных наименований, либо пустой список, если ничего не было найдено.
    * @throws IllegalArgumentException При всех полях, заданных пустыми строками, или при ошибке конвертации
    * price-полей во внутреннее числовое представление (BigDecimal).
    */
   public static List<Product> runSearch(String category, String product, String minPrice, String maxPrice) throws IllegalArgumentException {
      
      // Согласно тексту задания, хотя бы одно поле поиска должно быть указано.
      // Imho, эту проверку можно и опустить для "поиска всего" пустой формой.
      if("".equals(category) && "".equals(product) && "".equals(minPrice) && "".equals(maxPrice))
         throw new IllegalArgumentException("Заполните хотя бы одно поле формы поиска.");
      
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
            .setParameter("maxPrice", toBigDecimal(maxPrice, true));
         
         final List<Product> result = query.getResultList();
         session.close();
         return result;
      
      } catch (IllegalArgumentException ex) {
         throw ex;
      } catch (Throwable ex) {
         System.err.println("Has EntityManagerFactory been really closed?!?: " + ex);
      }
      
      // DUMMY
      return Collections.EMPTY_LIST;
   }
   
   private static BigDecimal toBigDecimal(String value, boolean higher) throws IllegalArgumentException {
      try {
         return new BigDecimal(value);
      } catch(NumberFormatException ex) {
         if("".equals(value))
            return higher
               ? BigDecimal.valueOf(Double.MAX_VALUE)
               : BigDecimal.ZERO;
         throw new IllegalArgumentException("Некорректное значение цены: " + value);
      }
   }
}
