package grp4.iotbay.Model;



public class Pay {

    private String amount;
    private int id;
    private String Created;
    private String Email;

    public Pay(String amount, int id, String Created) {
        this.amount = amount;
        this.id = id;
        this.Created = Created;
       
    }
       public Pay() {
         this.amount = amount;
        this.id = id;
        this.Created = Created;
    }
        public String getCreated() {
        return Created;
    }

    public void setCreated(String created) {
        this.Created = created;
    }
        public String getEmail() {
        return Email;
    }

    public void setEmail(String created) {
        this.Email = created;
    }


     public void setID(int name) {
        this.id = name;
    }

    public int getID() {
        return id;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String creditCardNumber) {
        this.amount = creditCardNumber;
    }



 
}