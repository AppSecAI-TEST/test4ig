package ru.simsonic.test4ig;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "prod")
public class Product implements Serializable {

   @Id
   private Integer    id;
   private Category   category;
   private String     name;
   private BigDecimal price;

   public Integer getId() {
      return id;
   }

   public void setId(Integer id) {
      this.id = id;
   }
}
