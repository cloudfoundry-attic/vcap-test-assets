package org.cloudfoundry.s2qa;

public class Item {

   private String id;

   private String itemCode;

   private String name;

    public Item() {
    }

    public Item(String itemCode, String name) {
        super();
        this.itemCode = itemCode;
        this.name = name;
    }

   public String getId() {
      return id;
   }

   public void setId(String id) {
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