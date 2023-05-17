package entities;

import enums.ProductType;
import java.awt.image.BufferedImage;
import java.util.ArrayList;

public class Product {
    String productName;
    ProductType productType;
    long productQuantity;
    double productPrice;
    String productDescription;
    BufferedImage productPicture;
    ArrayList<OrderLine> orderLines;

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

    public long getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(long productQuantity) {
        this.productQuantity = productQuantity;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public BufferedImage getProductPicture() {
        return productPicture;
    }

    public void setProductPicture(BufferedImage productPicture) {
        this.productPicture = productPicture;
    }

    public ArrayList<OrderLine> getOrderLines() {
        return orderLines;
    }

    public void setOrderLines(ArrayList<OrderLine> orderLines) {
        this.orderLines = orderLines;
    }
}