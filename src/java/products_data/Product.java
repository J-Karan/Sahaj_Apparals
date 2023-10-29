package products_data; 
public class Product {

    private Integer productCode;
    private String name;
    private String brand;
    private Double price;
    private String imageURL;
    private String description;
    private Integer rating;

    public Product(Integer productCode, String name, String brand, Double price, String imageURL, String description, Integer rating) {
        this.productCode = productCode;
        this.name = name;
        this.brand = brand;
        this.price = price;
        this.imageURL = imageURL;
        this.description = description;
        this.rating = rating;
    }

    public Integer getProductCode() {
        return productCode;
    }

    public String getBrand() {
        return brand;
    }

    public String getName() {
        return name;
    }

    public Double getPrice() {
        return price;
    }

    public String getImageURL() {
        return imageURL;
    }

    public String getDescription() {
        return description;
    }

    public Integer getRating() {
        return rating;
    }

}
