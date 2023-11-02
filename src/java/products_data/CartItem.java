package products_data;

public class CartItem {

    private final int productCode;
    private final String productTitle;
    private final String productURL;
    private final int quantity;
    private final Double productPrice;
    private final String desc;

    public CartItem(String productTitle, String productURL, int quantity, Double productPrice,String desc,int productCode) {
        this.productTitle = productTitle;
        this.productURL = productURL;
        this.quantity = quantity;
        this.productPrice = productPrice;
        this.desc=desc;
        this.productCode=productCode;
    }

    public String getProductTitle() {
        return productTitle;
    }

    public String getProductURL() {
        return productURL;
    }

    public int getQuantity() {
        return quantity;
    }
    
    public Double getProductPrice() {
        return productPrice;
    }

    public String getDesc() {
        return desc;
    }

    public int getProductCode() {
        return productCode;
    }
   
}
