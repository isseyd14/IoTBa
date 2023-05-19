package grp4.iotbay.Model;

import java.sql.Timestamp;


public class Payment {

    private String creditCardNumber;
    private String creditCardExpiry;
    private String creditCardCVC;
    private String Email;
    private String Name;
    private Timestamp Created;

    public Payment(String creditCardNumber, String creditCardExpiry, String creditCardCVC,String name ,String email) {
        this.creditCardCVC = creditCardCVC;
        this.creditCardExpiry = creditCardExpiry;
        this.creditCardNumber = creditCardNumber;
        this.Name = name;
        this.Email = email;
    }
       public Payment() {
        this.creditCardCVC = creditCardCVC;
        this.creditCardExpiry = creditCardExpiry;
        this.creditCardNumber = creditCardNumber;
        this.Name = Name;
        this.Email = Email;
        this.Created = Created;

    }
        public Timestamp getCreated() {
        return Created;
    }

    public void setCreated(Timestamp created) {
        this.Created = created;
    }


    public void setEmail(String email) {
        this.Email = email;
    }

    public String getEmail() {
        return Email;
    }
     public void setName(String name) {
        this.Name = name;
    }

    public String getName() {
        return Name;
    }

    public String getCreditCardNumber() {
        return creditCardNumber;
    }

    public String getCreditCardExpiry() {
        return creditCardExpiry;
    }

    public String getCreditCardCVC() {
        return creditCardCVC;
    }

    public void setCreditCardNumber(String creditCardNumber) {
        this.creditCardNumber = creditCardNumber;
    }

    public void setCreditCardExpiry(String creditCardExpiry) {
        this.creditCardExpiry = creditCardExpiry;
    }

    public void setCreditCardCVC(String creditCardCVC) {
        this.creditCardCVC = creditCardCVC;
    }
}