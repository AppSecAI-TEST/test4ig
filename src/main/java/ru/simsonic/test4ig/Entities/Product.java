package ru.simsonic.test4ig.Entities;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "prod")
public class Product implements Serializable {

   @Id
   @GeneratedValue(strategy = GenerationType.AUTO)
   private Integer    id;
   
   @ManyToOne
   @JoinColumn(name = "cat_id")
   private Category   category;
   
   private String     name;
   private BigDecimal price;
   
   public Product() {
   }
   
   public Product(Category category, String name, BigDecimal price) {
      this.category = category;
      this.name     = name;
      this.price    = price;
   }

   public Integer getId() {
      return id;
   }

   public void setId(Integer id) {
      this.id = id;
   }
   
   public Category getCategory() {
      return category;
   }
   
   public void setCategory(Category category) {
      this.category = category;
   }
   
   public String getName() {
      return name;
   }
   
   public void setName(String name) {
      this.name = name;
   }
   
   public BigDecimal getPrice() {
      return price;
   }
   
   public void setPrice(BigDecimal price) {
      this.price = price;
   }
}
