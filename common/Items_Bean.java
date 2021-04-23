package common;


public class Items_Bean {

    private int id;
    private String name;
    private String refno;
    private int starting_price;
    private int hidden_price;
    private boolean sold_status;
    private boolean deleteStatus;

    public boolean isDeleteStatus() {
        return deleteStatus;
    }

    public void setDeleteStatus(boolean deleteStatus) {
        this.deleteStatus = deleteStatus;
    }

    public Items_Bean() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRefno() {
        return refno;
    }

    public void setRefno(String refno) {
        this.refno = refno;
    }

    public int getStarting_price() {
        return starting_price;
    }

    public void setStarting_price(int starting_price) {
        this.starting_price = starting_price;
    }

    public int getHidden_price() {
        return hidden_price;
    }

    public void setHidden_price(int hidden_price) {
        this.hidden_price = hidden_price;
    }

    public boolean isSold_status() {
        return sold_status;
    }

    public void setSold_status(boolean sold_status) {
        this.sold_status = sold_status;
    }
}


