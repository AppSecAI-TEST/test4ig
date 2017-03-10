package ru.simsonic.test4ig;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cat")
public class Category implements Serializable {

   @Id
   private Integer id;
   private String  name;

   public Integer getId() {
      return id;
   }

   public void setId(Integer id) {
      this.id = id;
   }
}
