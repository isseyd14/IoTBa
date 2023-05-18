package entities;

import enums.CardType;

import java.util.ArrayList;


public class Customer extends User {
    String residentialAddress;
    String cardNum;
    CardType cardType;
    int cardExpiryYear;
    int cardExpiryMonth;
    int cardCvv;
    ArrayList<Order> orders;


    public String getResidentialAddress() {
        return residentialAddress;
    }

    public void setResidentialAddress(String residentialAddress) {
        this.residentialAddress = residentialAddress;
    }

    public String getCardNum() {
        return cardNum;
    }

    public void setCardNum(String cardNum) {
        this.cardNum = cardNum;
    }

    public CardType getCardType() {
        return cardType;
    }

    public void setCardType(CardType cardType) {
        this.cardType = cardType;
    }

    public int getCardExpiryYear() {
        return cardExpiryYear;
    }

    public void setCardExpiryYear(int cardExpiryYear) {
        this.cardExpiryYear = cardExpiryYear;
    }

    public int getCardExpiryMonth() {
        return cardExpiryMonth;
    }

    public void setCardExpiryMonth(int cardExpiryMonth) {
        this.cardExpiryMonth = cardExpiryMonth;
    }

    public int getCardCvv() {
        return cardCvv;
    }

    public void setCardCvv(int cardCvv) {
        this.cardCvv = cardCvv;
    }

    public ArrayList<Order> getOrders() {
        return orders;
    }

    public void setOrders(ArrayList<Order> orders) {
        this.orders = orders;
    }
}