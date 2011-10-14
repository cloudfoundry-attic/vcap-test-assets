package org.cloudfoundry.s2qa;

public class Item {

   private Long id;

   private String itemCode;

   private String name;

   public Long getId() {
      return id;
   }

   public void setId(Long id) {
      this.id = id;
   }

   public String getItemCode() {
      return itemCode;
   }

   public void setItemCode(String itemCode) {
      this.itemCode = itemCode;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   @Override
   public String toString() {
      return "Item[id=" + id + ", itemCode=" + itemCode + ", name="
         + name + "]";
   }

}
