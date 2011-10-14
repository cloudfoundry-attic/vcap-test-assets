package org.cloudfoundry.s2qa;

public class Tax {

   private Long id;

   private float taxCost;

   private float taxRate;

   private float taxTotal;

   public Long getId() {
      return id;
   }

   public void setId(Long id) {
      this.id = id;
   }

   public float getTaxCost() {
      return taxCost;
   }

   public void setTaxCost(float taxCost) {
      this.taxCost = taxCost;
   }

   public float getTaxRate() {
      return taxRate;
   }

   public void setTaxRate(float taxRate) {
      this.taxRate = taxRate;
   }

   public float getTaxTotal() {
      return taxTotal;
   }

   public void setTaxTotal(float taxTotal) {
      this.taxTotal = taxTotal;
   }

   @Override
   public String toString() {
      return "Tax[id=" + id + ", taxCost=" + taxCost + ", taxRate="
         + taxRate + ", taxTotal=" + taxTotal + "]";
   }

}