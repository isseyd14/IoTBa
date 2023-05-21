package grp4.iotbay.Model;

import java.io.Serializable;

public class Product implements Serializable {
    private String name;
    private String type;
    private String description;
    private int quantity;
    private double price;
    private int id;

    public Product() {

    }

    public Product(String name, String type, String description, int quantity, double price, int id) {
        this.name = name;
        this.type = type;
        this.description = description;
        this.quantity = quantity;
        this.price = price;
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return this.price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
        public double getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

}
